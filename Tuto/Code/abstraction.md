# Abstraction

[Video](https://www.youtube.com/watch?v=eyx25adnN6A)

## What does abstraction even means?
It means take away the functionality or **individuality** of certain **object**.
Cam have multiple **levels**.
The written description **is already** an abstraction.

## What is abstraction in code?
Take away the explanation **away** from the code.

``` c
if (key == 'a') {
    player.position.x -= player.velocity.x;
}
if (key == 'd') {
    player.position.x += player.velocity.x;
}
```

Abstracting... The player can move to the *left* or *right* depending on the key.
The **key** value of *abstraction* is to make **code** more **accessible** to other **people**.
