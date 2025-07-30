#!/bin/bash
mapfile -t files <<< $(fd .lua .)
for element in "${files[@]}"
do
  x=$(bunx lua-fmt $element)
  #echo "$x"
  echo "$element"
  echo "$x" > $element
done