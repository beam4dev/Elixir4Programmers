
# Create a new Elixir project

  mix new <project_name>

# Directory Structure

```
├───assets
├───lib    #here is the code of the project
└───test
 mix.exs   #the configuration of the project
```

# How to compile the project?
  mix

# How to run test?
  mix test

# Language Concepts


| Language Feature | Description |
|---|---|
| Block of code | A block of Elixir code can be grouped between the keywords `do` and `end`. |
| Module | A module is a collection of Elixir code. Modules are defined using the `defmodule` keyword. |
| Function | A function is a block of code that can be called by name. Functions are defined using the `def` keyword. |
| Module name | The name of a module must be an Elixir atom. Atoms are unchangeable values. |
| Function name | The name of a function can be a name or one of the Elixir operators. Names must start with a lowercase letter or underscore, and may contain letters, digits, and underscores. |
| IO.puts | The `IO.puts` function writes a string to standard output. |

# mix tool

| Tool | Description |
|---|---|
| `mix` | The `mix` tool is used to compile, run, and test Elixir projects. |
| `mix run` | The `mix run` command runs an Elixir project. |
| `mix run «code»` | The `mix run «code»` command executes the given code in the context of an Elixir project. |
| `iex -S mix` | The `iex -S mix` command starts the Elixir interactive shell (iex) in the context of an Elixir project. |
| `iex> r ModuleName` | The `iex> r ModuleName` command recompiles the file containing the module `ModuleName`. |
| `iex> c "lib/name.ex"` | The `iex> c "lib/name.ex"` command compiles the given file. |
