# Reflection on tools

## Prolog

Prolog is a logic programming language.

### Usage

Prolog allows a user describe relations between variables using Horn clauses (called rules and facts).
A rule has a Head that introduces variables and a Body that introduces predicates on these variables.
A user can run a query in the form of a rule, and the Prolog engine will try to find values for variables in Head such that all predicates in the query Body evaluate to true.

### Potential applications

- Search engines for a knowledge base.
- Assisting Large Language Models in reasoning.
- Intelligent agents in simulated environments.

## Z3

Z3 is an SMT solver.

### Usage

Given a symbolic formula in a certain theory, Z3 can try to find assignments of variables in the formula to make the formula valid.
It works with boolean values, numbers, strings, and other data types.

### Potential applications

- Identification of theorems
- Simulation of program execution
- Proof assistants
- LiquidHaskell - for statically proving correctness of Haskell programs

## Isabelle/HOL

Isabelle is an interactive and automated theorem prover.

### Usage

Isabelle allows to write mathematical proofs in a human-readable declarative manner.
It supports multiple formal methods.
It lets encode logics such as First-order logic and Higher-order logic.

### Potential applications

- Formal verification of programs
- Computer-aided formalization of mathematical texts
