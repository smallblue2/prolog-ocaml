(* Efficiently generate a list of integers from a to b *)
let rec range a b =
  if a > b then []
  else a :: range (a + 1) b

(* Efficient functional Sieve of Eratosthenes to find all primes up to n.
   It avoids marking non-primes in a mutable array and instead filters out non-primes from a list. *)
let sieve_of_eratosthenes n =
  let rec mark_primes primes = function
    | [] -> List.rev primes  (* Return the list of primes in ascending order *)
    | x :: xs -> (* For each number x in the list *)
      if List.exists (fun prime -> x mod prime = 0) primes then (* If x is divisible by any prime *)
        mark_primes primes xs  (* It's not a prime; proceed with the rest of the list *)
      else
        mark_primes (x :: primes) xs  (* x is a prime; add it to the primes list *)
  in
  mark_primes [] (range 2 n)  (* Initialize the marking process with an empty list of primes and a range from 2 to n *)

(* Function to calculate the number of factors of an integer n using the precomputed prime list *)
let num_of_factors n primes =
  let rec count_factors n p count =
    (* Count how many times the prime number p divides n *)
    if n mod p = 0 then
      count_factors (n / p) p (count + 1)  (* p divides n; increase the count and divide n by p *)
    else
      (n, count)  (* p no longer divides n; return n and the count *)
  in
  let rec helper n primes i total_factors =
    match primes with
    | [] -> total_factors  (* If no more primes, return the total_factors *)
    | p :: ps ->  (* For each prime p in the list *)
      if p * p <= n then
        let (n, count) = count_factors n p 0 in  (* Count the factors of n that are divisible by p *)
        helper n ps (i + 1) (total_factors * (count + 1))  (* Recursively count factors for the remaining primes *)
      else
        if n > 1 then total_factors * 2 else total_factors  (* If n is still greater than 1, it's a prime factor itself *)
  in
  helper n primes 0 1  (* Start the helper with the number n, the list of primes, index i as 0, and initial total_factors as 1 *)

(* Count the number of integers less than the limit for which the number and its successor have an equal number of factors *)
let rec count_same_factors limit primes =
  if limit <= 1 then 0  (* If limit is less than or equal to 1, return 0 *)
  else
    (* Calculate the number of factors for limit and limit - 1 *)
    let num1 = num_of_factors limit primes in
    let num2 = num_of_factors (limit - 1) primes in
    (* If they are equal, increment the count and continue with the next lower integer *)
    if num1 = num2 then 1 + count_same_factors (limit - 1) primes
    else count_same_factors (limit - 1) primes  (* Otherwise, just continue with the next lower integer *)

(* Function to print a list, useful for debugging *)
let rec print_list list =
  match list with
  | [] -> ()
  | [x] -> Printf.printf "%d\n" x
  | x :: xs -> Printf.printf "%d; " x; print_list xs

(* Validate command line arguments to ensure there is one argument and it is an integer *)
let validateCmdLine =
  if Array.length Sys.argv == 2 then
    match int_of_string_opt Sys.argv.(1) with
    | Some num -> (true, num)  (* If argument is a valid integer, return true with the number *)
    | None -> (false, -1)     (* If argument is not an integer, return false with -1 *)
  else
    (false, -1)               (* If incorrect number of arguments, return false with -1 *)

(* Main entry point of the program *)
let () = 
  let (validity, num) = validateCmdLine in
  if validity then 
    (* If the command line argument is valid, calculate the sum and print the answer *)
    let primes = sieve_of_eratosthenes num in 
    let ans = count_same_factors num primes in
    Printf.printf "%d\n" ans
  else 
    (* If the command line argument is invalid, print an error message *)
    Printf.printf "Invalid argument!\n"
