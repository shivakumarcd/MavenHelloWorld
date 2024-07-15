Trying first Maven Project on Mac:

Following Maven in 5 Minutes { - https://maven.apache.org/guides/getting-started/maven-in-five-minutes.html
    -"mvn -v" in "terminal" to check if maven already installed - gives "command not found"
    -Installing maven if not installed {
        -"Maven is a Java tool, so you must have Java installed in order to proceed"
        -"Follow the installation instructions" { - https://maven.apache.org/install.html
            -Detour - To perform "set the JAVA_HOME environment variable pointing to your JDK installation" {
                -to check java "java -version"
                -to check jdk installed - "javac -version"
                -checking if multiple java/JDKs present "/usr/libexec/java_home -V" {
                    -output {
                        Matching Java Virtual Machines (2):
                        22.0.1 (x86_64) "Oracle Corporation" - "Java SE 22.0.1" /Library/Java/JavaVirtualMachines/jdk-22.jdk/Contents/Home
                        20.0.2 (x86_64) "Oracle Corporation" - "Java SE 20.0.2" /Library/Java/JavaVirtualMachines/jdk-20.jdk/Contents/Home
                        /Library/Java/JavaVirtualMachines/jdk-22.jdk/Contents/Home
                    }
                    -Shows different JDKs present
                    Detour { - Trying to go to above path
                        -in Mac to "usr" folder hidden in "finder".. to show hidder folder/toggle - "Command + Shift + ."
                        -java_home in above command is a "unix executable file"}
                    -Currently my MAC has 22.0.1 & 20.0.2 & looks 22.0.1 is used as default as given by "java -version"
                }
                -Trying to set JAVA_HOME to use 20.0.2 & hoping this changes  output of "java -version" from above 22 to 20 {
                    -"vim ~/.bash_profile" (is using zsh - "vim ~/.zshrc") - file opened and already contained python-conda related stuff
                    -add below line anywhere in above file
                        export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-20.jdk/Contents/Home
                        export command creates new environment var. To check after export, use command "env" to check if its created
                    -"source ~/.bash_profile"  - looks it runs above file & 'java -version' gives 20
                    -********DIDN'T' WORK -> WORKED AFTER BELOW FIX**********{
                        -Issue: each time I restart "terminal.app", "java -version" going back to 22!!!!!!!!!!!!
                        -Cause & fix {
                            -MAC-terminal.app uses default shell. It could be "bash" or "zsh". For my machine it was zsh
                            -which shell is determined by command "echo $SHELL"
                            -Therefore I had to modify using "vim ~/.zshrc" instead of "vim ~/.bash_profile"
                            -Worked fine. "Java -version" giving 20...
                            - Detour { - other commands used to figure these things
                                - "env" -  to list all all enviroanment variable like "JAVA_HOME="
                                - "env | grep Java" - to filter lines containing "Java". grep can also be used with many other things like files, etc }
                        }
                    }
                    -Detour-what is this .bash_profile/.zshrc? {
                        -These are files, content of which are executed on "terminal.app" startup.
                        -Also, export JAVA_HOME=/Libra... can also be executed directly in terminal and change "env" content but gets lost
                        after closing terminal.app hence adding in .bash_profile/.zhrc  file}
                }
            }
            - Detour - To perform "Add the bin directory of the created directory apache-maven-3.9.8 to the PATH" {
                Using same logic used above for setting JAVA_HOME
                -Adding
                    export PATH=/Users/shivakumardoddamani/Desktop/a\ Home/My\ study/Java\ spring\ maven\ related/Maven/download/apache-maven-3.9.8/bin:$PATH
                    or
                    export PATH="/Users/shivakumardoddamani/Desktop/a Home/My study/Java spring maven related/Maven/download/apache-maven-3.9.8/bin:$PATH"
            }
        }
        CAUTION/NOTE {
            If you change/rename any folder in path where maven downloaded bin is present and as same path is used in above steps, "mvn --version" will stop working }
    }
    -Followed "Creating a Project" {
        -Created project using command "mvn archetype:generate -DgroupId=com.mycompany.app -DartifactId=my-app -DarchetypeArtifactId=maven-archetype-quickstart -DarchetypeVersion=1.4 -DinteractiveMode=false"

        -creates project trees strucure as  my-app - src - main - java - com - mycompany - app
                                                         - test - java - com - mycompany - app }
    -The POM {
        -"single configuration file that contains the majority of information required to build a project in just the way you want" }
    -"What did I just do?" {
        -"executed the Maven goal archetype:generate" with bunch of parameters
        -archetype in "mvn archetype:generate ..." is a plugin "that provides the goal"... (plugin:collection of goals. More on plugin vs goal later)
        -"archetype:generate goal created a simple project based upon a maven-archetype-quickstart archetype"
        }
    -"Build the Project" {
        -command "mvn package"
        -******DIDNT WORK -> WORKED AFTER BELOW FIX********* {
            -Issue- Build failing with below error (But it did create "target" folder but nothing classes folder)
            -ERROR- [ERROR] Source option 7 is no longer supported. Use 8 or later.
            -Cause & fix - Worked after changing <maven.compiler.source>1.7</maven.compiler.source> to 1.8. Now classes also created with many other things }
        -plugin vs goal vs phase & "build lifecycle" {
            -Goal: "mvn archetype:generate ..."  is a goal that "created a simple project based upon a maven-archetype-quickstart archetype"
            -plugin: "collection of goals"
            -Phase: "mvn package"   is a phase("phase: is a step in the build lifecycle(build lifecycle: ordered sequence of phases)")
            -Phase vs Goal: "Phases are actually mapped to underlying goals"
            -"When a phase is given, Maven executes every phase in the sequence up to and including the one defined"
            -Eg: Compile phase === validate -> generate-sources -> process-sources -> generate-resources -> process-resources -> compile }
        -above "mvn package" created target folder that has many files/subfolders like {
            -jar,
            -class folder with class files of resp java files
            -status folder with input files & files created info
            -test folder with test classes of resp java files
            -etc }
        -?????"Java 9 or later" {
            -To target java 11 ->  "<maven.compiler.release>11</maven.compiler.release>"
            -?????Notice there are 3 properties wrt Java version used {
                <maven.compiler.source>1.8</maven.compiler.source>
                                target>1.8</maven.compiler.target>
                                release>11</maven.compiler.release>
            }
            -Notice there is "maven-clean-plugin": may be this what referred/used when give "mvn clean" - which deletes "target" which got created earlier }
        -?????"Running Maven Tools" {
            "validate:          validate the project is correct and all necessary information is available"
            "compile:           compile the source code of the project". Worked. Compiles & shows error line in Java else compiles fine.
            "test:              test the compiled source code using a suitable unit testing framework. These tests should not require the code be packaged or
                                deployed". Test Fails appear in red if "assertTrue(2==3);". Else green.
            "package:           take the compiled code and package it in its distributable format, such as a JAR.". Till this point is what we did earlier
            ?????"integration-test: process and deploy the package if necessary into an environment where integration tests can be run"
            ?????"verify:       run any checks to verify the package is valid and meets quality criteria"
            ?????"install:      install the package into the local repository, for use as a dependency in other projects locally"
            "deploy:       done in an integration or release environment, copies the final package to the remote repository for sharing with other
                                developers and projects." }
    }
}
