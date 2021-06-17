#include <iostream>
#include <vector>

#include "arguments.h"

std::vector<std::string> create_vector(const char *data[], int length, bool isArguments = true)
{
    int counter = 0;
    std::vector<std::string> string_vector = std::vector<std::string>();
    while(counter < length)
    {
        if(isArguments)
        {
            if(counter == 0)
            {
                counter += 1;
                continue;
            }
        }
        string_vector.push_back(data[counter]);
        counter += 1;
    }
    return string_vector;
}

int main(int argc, const char *argv[])
{
    std::vector<std::string> as_vector = create_vector(argv, argc);
    ArgumentParser::ArgumentParser arguments = ArgumentParser::ArgumentParser(as_vector);
    arguments.parseArguments();
    return 0;
}

