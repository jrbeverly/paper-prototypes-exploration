---
title: Understanding before specification
---

**The assumption:** Better specifications produce better software.

**The question:** Does writing a detailed spec *before* you understand the problem actually produce better outcomes? Or does it just produce documents that look complete while encoding wrong assumptions?

---

Specifications communicate understanding. They do not create it.

This is the central premise of paper prototyping, and it is worth sitting with for a moment. No matter how carefully you document a system you have not yet built, you are documenting something you do not fully understand. The resulting specification can be thorough, well-structured, and completely wrong.

Teams invest enormous effort in upfront design documents. The reasoning is intuitive: if we describe everything in advance, the implementation will go smoothly. But software is not architecture in the physical sense. The behaviour of a system emerges from interactions that are difficult to predict from a static description. Edge cases, performance characteristics, and the actual experience of using the software rarely survive first contact with reality.

A prototype does not replace the specification. It *feeds* it. Build something small that exercises the riskiest assumption, watch what happens, and write the spec afterwards. The document you produce will be shorter, more accurate, and far more useful — because it describes something you have already begun to understand.

The recommended sequence is:

1. Identify a problem worth solving.
2. Build the cheapest possible prototype that tests your core assumption.
3. Observe what the prototype reveals.
4. Refine your understanding based on what you learned.
5. Document the conclusions.

The specification becomes the result of understanding rather than the mechanism for achieving it.
