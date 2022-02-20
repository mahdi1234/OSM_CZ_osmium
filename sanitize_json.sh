#!/bin/bash
## revert the file and make sure penultimate line before json closing doesn't contain comman at the end and revert again
tac | sed '2s/,$//' | tac
