---
title: Executable understanding
---

**The assumption:** Documentation is the best way to communicate understanding of a system.

**The question:** Can a small interactive artifact communicate an idea more effectively than pages of prose?

---

A simple interactive prototype often communicates more in five minutes than a specification document communicates in fifty pages.

This is not an argument against documentation. It is an observation about how understanding actually transfers between people. When you read a description of a workflow, you interpret it through your own mental model. Subtle mismatches between what the author meant and what the reader understood can survive unnoticed for weeks.

When you interact with a working example, those mismatches surface immediately. The behaviour is unambiguous. You click something, and something happens. If the behaviour matches your expectation, you have confirmed your understanding. If it does not, you have found a gap.

---

## Assumptions become visible

Even an incomplete prototype exposes assumptions that remain invisible in written specifications. A document can state "the user authenticates and then selects a project" without ever forcing the author to decide how many clicks that takes, what happens when the session expires midway, or whether the project list handles a thousand entries.

A prototype forces those decisions. The author must make the interaction concrete enough to execute. In doing so, they discover the questions they had not thought to ask.

This is the hidden value of executable understanding: it does not just communicate what you know — it reveals what you do not know yet.

---

## Communication across disciplines

Executable prototypes also improve communication between different kinds of people. A designer can interact with a prototype and notice that a transition feels jarring. A product owner can click through a flow and realise a step is missing. An engineer can inspect the code and see that an abstraction will not scale.

None of these observations requires a written specification. Each of them emerged from interacting with something tangible.

Shared understanding grows faster when participants can react to behaviour rather than descriptions of behaviour.