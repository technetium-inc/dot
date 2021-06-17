#ifndef FILE_READER_H
#define FILE_READER_H

#include <fstream>

class FileReader
{
public:
    std::string filename;

    FileReader(std::string filename)
    {
        this->filename = filename;
    }

    std::string read()
    {
        std::string line;
        std::ifstream file(this->filename);
        if(file.is_open())
        {
            std::string file_content;
            while(getline(file, line))
            {
                file_content += line;
            }
            return file_content;
        }
        auto exception = new Exception("Unable to read the file");
    }
};

#endif