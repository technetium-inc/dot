#ifndef ARGUMENTS_H
#define ARGUMENTS_H	

namespace ArgumentParser {
	class ArgumentParser {
		private:
		std::vector<std::string> arguments;

		public:
		ArgumentParser(std::vector<std::string> arguments){
			this->arguments = arguments;
		}

		void parseArguments() {
			std::string command = "help";
			std::cout << this->arguments.size();
			for(int index=0; index<this->arguments.size(); index++){
				std::string current_argument = this->arguments.at(index);
				if (index == 0){
					command = current_argument;
					continue;
				}
				bool isValidCommand = current_argument.rfind("--", 0);
				std::cout << isValidCommand << std::endl;
			}
		}
	};
}

#endif