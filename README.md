# malicious-chinchillaV2
------------------------

malicious-chinchillaV2 is the second version of the malicious series. This powershell script provides the user with the biggest combination of passwords a user can have.
Combined with vicious-chinchilla this is the ultimate password cracker. As parameters the user gives one or multiple keywords with additional flags.
malicious-chinchilla covers basically every combination you can do with the keywords.

Installation:
------------------------

Open any time of cmd, navigate to your dir of desire, type in git clone https://github.com/benstreich/malicious-chinchillaV2.git



    Syntax
    --------------------
    ~!: keyword,keyword;
        [MANDATORY][-p [string]Path] [--path]
        [-sc[int]1 || [int]2] [--specialcharacters[int]1 || [int]2]
        [-rv] [--reverse]
        [-n[int]] [--number[int]]
        [INTERNET CONNECTION REQUIRED][-d[int]] [--dictionary[int]]
        [-c] [--combination]

    Logic
    --------------------
    malicious-chinchillaV2 will process the command as follows:

    (~! meat; -pC:\ExamplePath...) Saves Results in a file at the prompted Path 
    
    (~!: zoo; -sc1...) Every upper/lowercase possibility plus every specialcharacter ('!', '?', '$', '^', '+', '-', '#', '{', '}', '[', ']', '/', '\', '*', '(', ')', '%', '&', '~') at every index with every         
    upper/lowercase Possibility.
    Possible Combinations with 1 Specialcharacters can be calculated like this:
    (2^keywordlength * keywordlength + 1) * 19

    e.g keywordlength = 3 (zoo has three letters)
    (2^3 * 3+1) * 19 = 608 combinations
    Plus the Standard 2^3 upper/lowercase Combinations making it 616 Combinations.
    Possible Combinations: zO/o

    (~!: chuck; -sc2...) Every upper/lowercase possibility plus every specialcharacter ('!', '?', '$', '^', '+', '-', '#', '{', '}', '[', ']', '/', '\', '*', '(', ')', '%', '&', '~') twice in the word at every possible Index covering all         
    Combinations possible with the keyword and two specialcharacters.
    Possible Combinations with 2 Specialcharacters can be calculated like this:
    ((((keywordlength + 2) * 19) * (keywordlength+1)) * 19) * 2^keywordlength

    e.g keywordlength = 5
    ((((5+2) * 19) * (5+1)) * (19)) * ([Math]::Pow(2, 5)) = 485184 Combinations
    Plus the Standard 2^5 upper/lowercase Combinations making it 485216 Combinations.
    Possible Combinations: !cH&Uck

    (~!: mouse; -rv...) Every upper/lowercase possibility plus every upper/lowercase possbility in reverse
    Possible Combination: eSuom

    (~!: t-rex; -n10...) Every upper/lowercase possibility plus every number at every index
    Possible Combination: t-3rex
    ((2^keywordlength) * (keywordlength + 1)) * (10 + 1) = 2112 Combinations
    Plus the Standard 2^5 upper/lowercase Combinations making it 2144 Combinations.
    Possible Combinations: t-RE10x

    (~!: melon; -d3...) Prompts you 3 additional synonyms that are thrown into the mix and are processesed depending on the other flags prompted.

    All of the above can be combined of course

    (~!: party, lemon; -c...) when multiple keywords are prompted mc will generate every combination with the keywords and will process it depending on the other flags promnpted.

