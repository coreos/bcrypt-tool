package main

import (
	"bytes"
	"flag"
	"fmt"
	"os"

	isatty "github.com/mattn/go-isatty"
	"golang.org/x/crypto/bcrypt"
	"golang.org/x/crypto/ssh/terminal"
)

const Version = "not build correctly"

func fatalf(format string, a ...interface{}) {
	fmt.Fprintf(os.Stderr, format, a...)
	os.Exit(2)
}

func getPassword(prompt string) ([]byte, error) {
	fmt.Print(prompt + " ")
	pw, err := terminal.ReadPassword(int(os.Stdin.Fd()))
	fmt.Println()
	return pw, err
}

func main() {
	cost := flag.Int("cost", bcrypt.DefaultCost, "The bcrypt cost.")
	version := flag.Bool("version", false, "Print the bcrypt version then exit.")
	flag.Parse()

	if *version {
		fmt.Println(Version)
		os.Exit(0)
	}

	if !isatty.IsTerminal(os.Stdout.Fd()) {
		fatalf("this tools requires an interactive session\n")
	}

	pw1, err := getPassword("Enter password:")
	if err != nil {
		fatalf("read password: %v\n", err)
	}

	pw2, err := getPassword("Re-enter password:")
	if err != nil {
		fatalf("read password: %v\n", err)
	}

	if !bytes.Equal(pw1, pw2) {
		fatalf("passwords did not match\n")
	}

	out, err := bcrypt.GenerateFromPassword(pw1, *cost)
	if err != nil {
		fatalf("encrypting password: %v\n", err)
	}

	fmt.Printf("%s\n", out)
}
