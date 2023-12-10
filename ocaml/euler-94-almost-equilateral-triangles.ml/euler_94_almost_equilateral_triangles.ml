(* Function checks to see if a number x is a perfect square *)
let isPerfectSquare x =
  if x < 0 then false
  else
    let root = int_of_float (sqrt (float_of_int x)) in
    root * root = x

(* Function returns if the area of a triangle with sides 'x', 'x', and 'x + delta'
   (where delta is either -1 or 1) is an integer or not *)
let integralArea x delta =
  let formula = (4 * x * x) - ((x + delta) * (x + delta)) in
  isPerfectSquare formula

(* Recursive function to sum the perimeters of triangles that satisfy the 'almost equilateral'
   property and have integral areas. Iterates from base side length 'i' to 'limit' *)
let rec sum_perimeters i limit total =
  if (3 * i + 1) >= limit && (3 * i - 1) >= limit then
    total  (* Return the accumulated total if both conditions exceed the limit *)
  else
    (* If the area for the triangle with side 'i' and base 'i+1' is integral, add its perimeter *)
    let total = if integralArea i 1 then total + (3 * i + 1) else total in
    (* If the area for the triangle with side 'i' and base 'i-1' is integral, add its perimeter *)
    let total = if integralArea i (-1) then total + (3 * i - 1) else total in
    (* Recur for the next side length *)
    sum_perimeters (i + 1) limit total

(* Wrapper function to start the perimeter summation from side length 2 *)
let total_sum limit =
  sum_perimeters 2 limit 0

(* Validate command line input to ensure there is one argument and it is an integer *)
let validateCmdLine =
  if Array.length Sys.argv == 2 then
    match int_of_string_opt Sys.argv.(1) with
    | Some num -> (true, num)  (* Return true with the number if valid *)
    | None -> (false, -1)     (* Return false with -1 if not a valid integer *)
  else
    (false, -1)               (* Return false with -1 if incorrect number of arguments *)

(* Entry point of the program *)
let () =
  let (validity, num) = validateCmdLine in
  if validity then
    (* If command line argument is valid, calculate and print the total sum *)
    Printf.printf "%d\n" (total_sum num)
  else
    (* Print error message if the argument is invalid *)
    Printf.printf "Invalid argument!\n"
