(* check if command line args are valid *)
let validateCmdLine =
  if Array.length Sys.argv == 2 then
    match int_of_string_opt Sys.argv.(1) with
    | Some num -> (true, num)
    | None -> (false, -1)
    else
      (false, -1)

(* Remove multiples of a given number from a list *)
let rec remove_multiples n = function
  | [] -> []
  | x :: xs -> if x mod n = 0 then remove_multiples n xs else x :: remove_multiples n xs

(* The sieve function takes a list of integers and returns a list of primes *)
let rec sieve = function
  | [] -> []
  | x :: xs -> x :: sieve (remove_multiples x xs)

(* Generate a list of integers from 2 to n *)
let rec up_to_2 n =
  if n < 2 then []
  else up_to_2 (n-1) @ [n]

(* Find all primes up to a given limit *)
let primes_up_to n = sieve (up_to_2 n)

(* Function to print a list *)
let rec print_list list =
  match list with
  | [] -> ()
  | [x] -> Printf.printf "%d\n" x
  | x :: xs -> Printf.printf "%d; " x; print_list xs

let () = 
  let (validity, num) = validateCmdLine
  in if validity then 
    let n = primes_up_to 1000
      in print_list n
  else Printf.printf "Invalid argument!\n"
