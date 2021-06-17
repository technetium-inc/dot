#ifndef ARGUMENTS_H
#define ARGUMENTS_H

#include <numeric>
#include "exception.h"

namespace ArgumentParser
{
// The key value pairs
// Similar to a dictionary
struct ValueKeyPair
{
    std::string key;
    std::string value;
};

class ArgumentParser
{
private:
    std::vector<std::string> arguments;

    std::string string_from_vector(const std::vector<std::string> &data)
    {
        return std::accumulate(data.begin(), data.end(), std::string(""));
    }

    ValueKeyPair* getParameter(std::vector<std::string> data)
    {
        ValueKeyPair* parameter;
        if(data.size() == 0)
        {
            parameter->key = "";
            parameter->value = "";
        }
        else if(data.size() == 1)
        {
            parameter->key = data.at(0);
            parameter->value = "";
        }
        else
        {
            parameter->key = data.at(0);
            std::vector<std::string> sliced_vector = this->slice(data, 1, data.size()-1);
            parameter->value = this->string_from_vector(sliced_vector);
        }
        return parameter;
    }

    template<typename T>
    std::vector<T> slice(std::vector<T> const &v, int m, int n)
    {
        auto first = v.cbegin() + m;
        auto last = v.cbegin() + n + 1;

        std::vector<T> vec(first, last);
        return vec;
    }

    std::vector<std::string> split(std::string data, char character)
    {
        std::vector<std::string> return_value = std::vector<std::string>();
        std::string current_string_value = "";
        for(int index=0; index<data.length(); index++)
        {
            char current_character = data[index];
            if(current_character == character)
            {
                return_value.push_back(current_string_value);
                current_string_value = "";
                continue;
            }
            current_string_value += current_character;
        }
        if(current_string_value.length() > 0)
        {
            return_value.push_back(current_string_value);
        }
        return return_value;
    }

public:
    ArgumentParser(std::vector<std::string> arguments)
    {
        this->arguments = arguments;
    }

    void parseArguments()
    {
        std::string command = "help";
        std::cout << this->arguments.size();
        for(int index=0; index<this->arguments.size(); index++)
        {
            std::string current_argument = this->arguments.at(index);
            if (index == 0)
            {
                command = current_argument;
                continue;
            }
            bool isInvalid = current_argument.rfind("--", 0);
            if(isInvalid)
            {
                auto exception = new Exception(current_argument + " is not a valid parameter", "parameter keys should start with --");
            }
            std::vector<std::string> data = this->split(current_argument, '=');
            std::cout << getParameter(data) << std::endl;
        }
    }
};
}

#endif