(* Sieve of Eratosthenes *)
let sieve threshold =
  (* keep numbers that aren't mutiples of p *)
  let rec remove_multiples p = function
    | [] -> []
    | x :: xs -> if x mod p = 0 then remove_multiples p xs else x :: remove_multiples p xs
  in

  (* filter out non-primes (sieve of eratosthenes) *)
  let rec sieve_helper = function
    | [] -> []
    | p :: xs -> p :: sieve_helper (remove_multiples p xs)
  in

  let limit = int_of_float (sqrt (float_of_int threshold)) in (* only need to check up until sqrt(threshold) *) 
  let numbers = List.init (limit - 1) (fun i -> i + 2) in
  sieve_helper numbers

module IntSet = Set.Make(Int)

let power_triples_calc primes threshold =
  (* add numbers to set if < threshold *)
  let add_if_below_threshold fourth acc =
    if fourth < threshold then IntSet.add fourth acc 
    else acc
  in

  (* all primes for the fourth power *)
  let rec loop_fourth p_cubed acc = function
    | [] -> acc
    | p_fourth :: t ->
        let fourth = p_cubed + p_fourth * p_fourth * p_fourth * p_fourth in (* adding fourth to the cubed *)
        loop_fourth p_cubed (add_if_below_threshold fourth acc) t
  in

  (* all primes for the cube *)
  let rec loop_cubed p_square acc = function
    | [] -> acc
    | p_cubed :: t ->
        let cubed = p_square + p_cubed * p_cubed * p_cubed in (* adding cubed to the squared *)
        loop_cubed p_square (loop_fourth cubed acc primes) t (* pass to fourth *)
  in

  (* all primes for the square *)
  let rec loop_square acc = function
    | [] -> acc
    | p_square :: t ->
        let square = p_square * p_square in (* get the square of each prime *)
        loop_square (loop_cubed square acc primes) t (* pass to cubed *)
  in

  IntSet.cardinal (loop_square IntSet.empty primes)


let () =
  if Array.length Sys.argv <> 2 then
    Printf.printf "Usage: ./euler_87_prime_power_triples <threshold>\n"
  else
    try
      let threshold = int_of_string Sys.argv.(1) in
      if threshold <= 0 then
        Printf.printf "Negative threshold value provided\n"
      else
        let primes = sieve threshold in
        let sums = power_triples_calc primes threshold in
        Printf.printf "%d\n" sums
    with
    | Failure _ -> Printf.printf "Invalid integer\n"
    | _ -> Printf.printf "Random error\n"

