#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/wait.h>

#define MAX_COMMAND_LENGTH 100
#define MAX_ARGS 10

// Function to display the ASCII text logo
void displayLogo()
{
    puts("    __    _  _    __    ____   ___  _   _  _  _    ____  _____  _  _  _  _ ");
    puts("   /__\\  ( \\( )  /__\\  (  _ \\ / __)( )_( )( \\/ )  ( ___)(  _  )( \\/ )( \\/ )");
    puts("  /(__)\\  )  (  /(__)\\  )   /( (__  ) _ (  \\  /    )__)  )(_)(  )  (  \\  / ");
    puts(" (__)(__)(_)\\_)(__)(__)(_)\\_) \\___)(_) (_) (__)   (__)  (_____)(_/\\_) (__)  ");
    puts("   ___  _   _  ____  __    __   ");
    puts(" / __)( )_( )( ___)(  )  (  )  ");
    puts(" \\__ \\ ) _ (  )__)  )(__  )(__ ");
    puts(" (___/(_) (_)(____)(____)(____)");
}

// Function to parse the input command and arguments
void parseCommand(const char* input, char* command, char** arguments)
{
    char* token;
    int argIndex = 0;

    token = strtok(input, " \t\n\r\f\v");
    strcpy(command, token);

    while (token != NULL)
    {
        token = strtok(NULL, " \t\n\r\f\v");
        if (token != NULL)
            arguments[argIndex++] = strdup(token);
    }
    arguments[argIndex] = NULL;
}

// Function to execute a command with arguments
void executeCommand(const char* command, char* const arguments[])
{
    if (strcmp(command, "exit") == 0)
    {
        printf("Anarchy Foxy Says Goodbye!\n");
        exit(0);
    }

    pid_t pid = fork();

    if (pid < 0)
    {
        perror("Fork error");
    }
    else if (pid == 0)
    {
        // Child process executes the command
        execvp(command, arguments);
        perror("Command execution error");
        exit(EXIT_FAILURE);
    }
    else
    {
        // Parent process waits for the child to complete
        waitpid(pid, NULL, 0);
    }
}

int main()
{
    char input[MAX_COMMAND_LENGTH];
    char command[MAX_COMMAND_LENGTH];
    char* arguments[MAX_ARGS];

    displayLogo();

    while (1)
    {
        printf("\nAnarchy Foxy Shell :> ");
        fgets(input, sizeof(input), stdin);

        // Remove newline character from input
        input[strcspn(input, "\n")] = 0;

        parseCommand(input, command, arguments);
        executeCommand(command, arguments);

        // Free allocated memory for arguments
        for (int i = 0; arguments[i] != NULL; i++)
        {
            free(arguments[i]);
            arguments[i] = NULL;
        }
    }

    return 0;
}
