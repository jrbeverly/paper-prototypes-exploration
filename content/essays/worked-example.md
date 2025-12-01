---
title: A worked example
---

**The situation:** A team needs to add notifications to their application.
Emails when a report is ready. A summary when a batch job completes. An alert
when something breaks.

**The question:** Does this need a message queue on day one? Or can the team
start simple and evolve?

---

The team had been here before. A previous project started with a lightweight
notification approach and needed a painful migration to a message queue six
months later. The instinct this time was to spec out the full architecture
upfront — topics, dead-letter queues, retry policies, the works.

Instead, they built a prototype.

---

## The prototype

Fifteen lines of code. A single function that accepted a recipient, a subject,
and a body, and called the email provider's SDK:

```python
def notify(recipient: str, subject: str, body: str) -> bool:
    try:
        email_client.send(
            to=recipient,
            subject=subject,
            body=body,
        )
        return True
    except EmailError:
        return False
```

No queue. No retry. No abstraction. Just the simplest thing that could possibly
send an email.

They wired it into three places: the report generator, the batch job runner,
and the alert monitor. The whole exercise took under an hour. The code was
meant to be thrown away before anyone saw it.

The plan was to learn from the wiring, not from the function.

---

## What they observed

**It worked for two of the three cases.** Reports and alerts were fine — the
call returned quickly and the caller could proceed regardless of whether the
send succeeded. But the batch job runner called `notify` in a loop for each
recipient. The third recipient's email would time out waiting for the first two
to complete.

**Testing was revealing.** Writing a unit test for the report generator meant
mocking the email client. Easy enough — but the test doubled in size because it
had to account for success, failure, and timeout cases that were invisible in
the code but unavoidable at runtime.

**The failure mode surprised them.** When the email provider was slow, the
application did not just delay one notification — it delayed everything waiting
on that code path. A problem they would not have predicted from a diagram.

---

## What they learned

The question was never "do we need a queue?" The question was "where does the
async boundary belong?"

The prototype answered it. The boundary belongs between the caller and the
notification, not between the notification and the provider. Every caller
needed to *enqueue and forget*, but the delivery mechanism — in-process HTTP
call, out-of-process worker, or full message broker — should be an
implementation detail behind that boundary.

The queue might come later. The interface had to come now.

---

## The specification that followed

Armed with an hour of concrete experience, the team wrote a specification that
was shorter and sharper than what they would have produced upfront:

1. **Define a `Notifier` interface** with a single method:
   `send(notification) -> void`. The method is fire-and-forget. Callers do not
   wait for delivery. They hand off the notification and continue.

2. **The initial implementation calls the email provider synchronously.** It is
   ten lines of code. It exists to satisfy the interface so the rest of the
   system can be built against something real.

3. **The interface hides the delivery mechanism.** When the team later needs a
   queue, they swap the implementation behind the interface — nothing else
   changes. The async boundary is in the right place from the start.

4. **Tests are written against the interface.** The mock is trivial. Integration
   tests against the real provider are separate and optional. The test strategy
   emerged from the prototype, not from speculation.

The spec that might have been fifteen pages of queue topology became two pages
of interface design. The difference was an hour of prototyping.

---

## Why this matters

The prototype did not answer every question. It did not need to. It answered
the one question that mattered: *what does the caller actually need from a
notification system?*

The answer — "hand off the notification and keep moving" — was not obvious from
the requirements document. It became obvious the moment the team wired up a
real call and watched it block.

This is the argument for prototyping. Not that specifications are useless, but
that an hour of experimentation produces better specifications than a day of
speculation. The prototype is cheaper than the wrong architecture. The learning
is cheaper than the rewrite.

The team did not build a notification system. They built a question. And the
answer saved them months.
