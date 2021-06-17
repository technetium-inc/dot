#ifndef EXCEPTION_H
#define EXCEPTION_H

class Exception
{
private:
    std::string message;
    std::string suggestion;
    bool isFatal;
    int exitStatusCode;

    void throwException()
    {
        std::cout << this->message << std::endl;
        if(this->suggestion.length() > 0)
        {
            std::cout << this->suggestion << std::endl;
        }
        if(this->isFatal)
        {
            exit(this->exitStatusCode);
        }
    }

public:
    Exception(std::string message, std::string suggestion="", bool isFatal=true, int exitStatusCode=1)
    {
        this->message = message;
        this->suggestion = suggestion;
        this->isFatal = isFatal;
        this->exitStatusCode = exitStatusCode;

        this->throwException();
    }
};

#endif