# Snake Game

1. Log in to GitHub in VS Code by clicking the user icon in the bottom left corner (above gearbox). In the VSCode terminal, clone the repo to your local machine using the repo URL obtained while accepting the assignment.  
```sh
     git clone <your-repo-url>
```
     
2. Attempt the tasks mentioned in [https://cs61c.org/fa23/projects/proj1/#conceptual-overview](https://cs61c.org/fa23/projects/proj1/#conceptual-overview) and make changes to only `src/snake.c`, `src/state.c`, and `src/custom_tests.c`.
   
4. Run the following commands locally
```sh
   make run-unit-tests  
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
