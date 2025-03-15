use std::any::type_name;

fn print_type_of<T>(_: &T) {
    println!("{}", type_name::<T>());
}

fn main() {
    // การประกาศตัวแปรแบบ implicit
    let number = 10; // i32
    let message = "Hello"; // &str
    let pi = 3.14; // f64

    // แสดงประเภทของตัวแปร
    print_type_of(&number); // Output: i32
    print_type_of(&message); // Output: &str
    print_type_of(&pi); // Output: f64
}
