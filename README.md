# malicious-chinchillaV2
------------------------

malicious-chinchillaV2 is the second version of the malicious series. This powershell script provides the user with the biggest combination of passwords a user can have.
Combined with hashcat this is the ultimate password cracker. As parameters the user gives one or multiple keywords. Additionally you can choose to have numbers and specialcharacters.
malicious-chinchilla covers basically every combination you can do with the keywords.

malicious-chinchillaV2
    --------------------
    Version: 2.89
    Other works: Devious-ChinchillaV1-3


    Syntax
    --------------------
    ~!: keyword,keyword;
        [-sc[int]1 || [int]2] [--specialcharacters[int]1 || [int]2]
        [-rv] [--reverse]
        [-p [string]Path] [--path]
        [-n[int]] [--number[int]]
        [-d[int]] [--dictionary[int]]
        [-c] [--combination]

    Logic
    --------------------
    malicious-chinchillaV2 will process the command as follows:

    (~!: zoo; -sc1) Every upper/lowercase possibility plus every specialcharacter ('!', '?', '$', '^', '+', '-', '#', '{', '}', '[', ']', '/', '\', '*', '(', ')', '%', '&', '~') at every index with every         
    upper/lowercase Possibility.
    Possible Combinations with 1 Specialcharacters can be calculated like this:
    (2^keywordlength * keywordlength + 1) * 19

    e.g keywordlength = 3 (zoo has three letters)
    (2^3 * 3+1) * 19 = 608 combinations
    Plus the Standard 2^3 upper/lowercase Combinations making it 616 Combinations.
    Possible Combinations: zO/o

    (~!: chuck; -sc2) Every upper/lowercase possibility plus every specialcharacter ('!', '?', '$', '^', '+', '-', '#', '{', '}', '[', ']', '/', '\', '*', '(', ')', '%', '&', '~') twice in the word at every possible Index covering all         
    Combinations possible with the keyword and two specialcharacters.
    Possible Combinations with 2 Specialcharacters can be calculated like this:
    ((((keywordlength + 2) * 19) * (keywordlength+1)) * 19) * 2^keywordlength

    e.g keywordlength = 5
    ((((5+2) * 19) * (5+1)) * (19)) * ([Math]::Pow(2, 5)) = 485184 Combinations
    Plus the Standard 2^5 upper/lowercase Combinations making it 485216 Combinations.
    Possible Combinations: !cH&Uck
   
