# malicious-chinchillaV2

malicious-chinchillaV2 is the second version of the chinchilla series. This script provides the user with the biggest combination of passwords a user can have.
Combined with vicious-chinchilla this is the ultimate password cracker. As parameters the user gives one or multiple keywords with additional flags.
malicious-chinchilla covers basically every combination you can do with the keywords.



## Run Locally

Clone the project

```bash
  git clone https://github.com/benstreich/malicious-chinchillaV2.git
```

Go to the project directory

```bash
  cd my-project
```

## Usage/Examples

The syntax might seem confusing at first, but i promise you its not as complicated as it looks 😭

### Usage
```
~!: keyword,keyword,...;
        [MANDATORY][-p [string]Path] [--path]
        [-sc[int]1 || [int]2] [--specialcharacters[int]1 || [int]2]
        [-rv] [--reverse]
        [-n[int]] [--number[int]]
        [INTERNET CONNECTION REQUIRED][-d[int]] [--dictionary[int]]
        [-c] [--combination]

```


| Flag             | Function                                                                |
| ----------------- | ------------------------------------------------------------------ |
| -p | Outputs the Textfile with the saved combination at the given path|
| -sc | Either 1 or 2 Specialcharacters are being mixed in with the combiantions |
| -rv | Every given keyword is also being reversed and combined |
| -n | 0 till given Number is being mixed into the combination |
| -d | For every given Keyword mc will prompt you additional synonyms and will combine it (Internet connection is required here|
| -c | For every given Keyword mc will combine the keywords with every possibility of the given keywords (has to be multiple keywords) |







### Examples
```
~$: zoo; -pC:\Users
~$: lemon; -pC:\Users -sc2
~$: pie, mouse; -pC:\Users -sc2 -n10
~$: t-rex; -pC:\Users -rv -n4
~$: melon; -pC:\Users --dictionary1 -n4 -sc1
~$: vegan,love; -pC:\Users -c -n20 -sc1
```







    
## Preview

![image](https://github.com/benstreich/malicious-chinchillaV2/assets/90034208/b4f51cbd-690a-40a3-b78d-15a41087579b)


## License
[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/)

## Related

[vicious-chinchilla](https://github.com/benstreich/vicious-chinchilla)

