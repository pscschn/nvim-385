#!/bin/bash
mapfile -t files <<< $(fd .lua .)
for element in "${files[@]}"
do
  x=$(bunx lua-fmt $element)
  #echo "$x"
  echo "$x" > $element
done