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
    keyword,keyword,...; ([-sc] for specialcharacters) ([-n{int}] for number)
    e.g. zoo,cheetah; -n10 -sc -pcC:\Users\Example

    Logic
    --------------------
    malicious-chinchillaV2 will process the command as follows:

    Keyword foundations: zoo, zoocheetah, cheetah, cheetahzoo, ooz, hateechooz, hateech, oozhateech

    Foreach of these Keyword foundations every single upper/lowercase possibility is covered (e.g. hAteeCHooz, CHEETaHzoO)
    
    Additionally if -n{int} is prompted. Each of these upper/lowercase possibilities with the Key foundations gets every number from
    0 to the prompted number on every index. For example the currentcombination of cheetah with the upper/lowercase possibilities
    is CHeeTah so with the numbers it'll look like this: 0CHeeTah, C0HeeTah, CH0eeTah ect. and that foreach of the keyword Foundations
    with every sinlge upper/lowercase possibility and for every number at every index.
   
    Additionally if -sc is prompt. The whole thing with the numbers is done again with Special Characters.
    It would look something like this: #OoZ, O#oZ, Oo#Z ect.

    If both -sc and -n is prompted. The two are combined and will result in something like this:
    #0cheetah, 0#cheetah, 0c#heetah, 0ch#eetah ect. Till the special character is through all indexes. Then the special characters
    rotate and the whole thing again with the new sc until every sc is through. After that the Number moves:
    #c0heetah, c#0heetah, c0#heetah ect. Till the number is through all the indexes (with the above descripted process of all sc
    going through every index). Then the number changes and the whole thing from the beginning: #1cheetah, 1#cheetah, 1c#heetah ect.
    This whole process is going as long as the number is not at its prompted. Then the whole whole thing is done for every single
    upper/lowercase possibility. So every possible possibility is covered for every upper/lowercase, every number, every special character
    at every single index.
