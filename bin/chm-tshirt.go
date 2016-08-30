// #!/usr/bin/go run

// translate Computer History Museum t-shirt
// http://i.ebayimg.com/images/g/qksAAOSwaB5XjsI1/s-l300.jpg

package main

import (
	"fmt"
	"strconv"
)

func main() {
	var binaryStrings [3]string
	binaryStrings = [3]string{"01000011","01001000","01001101"}

	for _,bin := range binaryStrings {
		if decimal, err := strconv.ParseInt(bin, 2, 64); err != nil {
			fmt.Println(err)
		} else {
			letter := string(decimal)
			fmt.Println(bin, decimal, letter)
		}
	}
}
