# Snake Game

1. Log in to GitHub in VS Code by clicking the user icon in the bottom left corner (above gearbox). In the VSCode terminal, clone the repo to your local machine using the repo URL obtained while accepting the assignment.  
```sh
     git clone <your-repo-url>
```
     
2. Attempt the tasks mentioned in [https://cs61c.org/fa23/projects/proj1/#conceptual-overview](https://cs61c.org/fa23/projects/proj1/#conceptual-overview) and make changes to only `src/snake.c`, `src/state.c`, and `src/custom_tests.c`.
   
4. Run the following commands locally
```sh
   make run-unit-tests 
   make run-unit-tests-<1 to 6 except 2>  
   make run-integration-tests
```
   to see how your code is doing.

5. commit your changes to the GitHub repo by running
  ```sh
   git add -A
   git commit -m "<commit message>"
   git push origin main
  ```
    
6. For seeing the logs/cmd line output of auto-grading:   
   Go to your repo URL> open the actions tab > click latest workflow run > autograding


# Using Git

We just need very basic knowledge of git. You may go over the links bellow.

- [Git Videos](https://git-scm.com/videos)
- [Git Book](https://git-scm.com/book/en/v2/): You can go over chapters 1,2,3 (mostly we will only need 2).
- [Github for beginners in 2023](https://www.youtube.com/watch?v=vwj89i2FmG0)

# Using Make

You will not be needing much knowledge of make for the project, since the makefile is already given to you. You will
not be required to change it unless you are doing something very advanced. The following reference is provided to help you understand how it works. Knowing it would be helpful in the future.

- [Makefiletutorial](https://makefiletutorial.com/)
- [Make files in GPI Course at CMU](https://www.cs.cmu.edu/~15131/f17/topics/makefiles/)

# Misc

Following are some generally useful links for programmers 
- [https://missing.csail.mit.edu/](https://missing.csail.mit.edu/)
- [Great Practical Ideas in CS](https://www.cs.cmu.edu/~15131/f17/)
