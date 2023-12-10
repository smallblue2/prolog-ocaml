(* convert int to list *)
let rec digits_of_int store n =
  if n = 0 then store (* smallest at head *)
  else digits_of_int (n mod 10 :: store) (n / 10) (* reversed w/ mod *)

(* convert hold to list*)
let rec append_hold hold = 
  if hold = 0 then [] 
  else hold mod 10 :: append_hold (hold / 10)

(* here we multiply each num in the list by factor, and add hold*)
let rec mul_digits factor digits hold =
  match digits with
  | [] -> append_hold hold (* no more, add remainder from hold *)
  | h :: t ->
      let prod = h * factor + hold in
      (prod mod 10) :: mul_digits factor t (prod / 10) (* append least sig. to list *)

(* here we calculate factorial of n*)
let factorial n =
  let rec fact digits factor =
    if factor > n then digits (* if num we multiply by is greater than n, finish *)
    else fact (mul_digits factor digits 0) (factor + 1) (* multiply, increment*)
  in
  fact [1] 2 (* 1 is initial val *)

(* add all the digits in the list *)
let rec sum_digits = function
  | [] -> 0
  | h :: t -> h + sum_digits t (* add head to sum of tail *)

(* "main" where we print and take in args *)
let () =
    (* if we don't have correct no cmdline args *)
    if Array.length Sys.argv <> 2 then
      Printf.printf "Usage: ./euler_20_factorial_digit_sum <n>\n"
    else
      try
        let x = int_of_string Sys.argv.(1) in (* take in command line arg *)
        if x < 0 then 
          Printf.printf "Invalid number given: %d\n" x
        else
        let digits = factorial x in
        let sum = sum_digits digits in
        Printf.printf "%d\n" sum
      with (* error handling *)
      | Failure _ -> Printf.printf "Invalid integer\n"
      | _ -> Printf.printf "Random error\n"
 