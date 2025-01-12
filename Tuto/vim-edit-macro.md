# Macros in Vim / Neovim

## What is a macro

A macro is a **list of keys** that can be used later.

## How to create a macro

To create a macro press `q` follow by a letter (for example `a`).
This enters the record "mode", in this mode every key is put on a register (for exemple the `@a`) that can be reused.
To stop recording press `q` again.

## How to edit a macro

If you already create a macro but want to modify it you can do the following.

1. ### Create a new buffer

```
:new
```

2. ### Put the content of a macro on this buffer

```
:put [letter]
```

Exemple for put the `a` macro:

```
:put a
```

3. ### Make any changes and **don't** save

4. ### Update the macro

In normal mode and on the line.

```
"[letter]yy
```

Example for edit the `a` macro:

```
"ayy
```
