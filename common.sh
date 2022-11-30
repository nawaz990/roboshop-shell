STAT() {
  if [ $1 -eq 0 ]; then
    echo SUCCESS
  else
    echo FAILURE
    exit
  fi
}

PRINT() {
  echo -e "\e[33m$1\e[0m"
}