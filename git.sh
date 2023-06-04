alias ggs="git status"

function ggp() 
{
  local str="$1"
  git add .;
  git commit -m "$str";
  git push;
  git status;
}

