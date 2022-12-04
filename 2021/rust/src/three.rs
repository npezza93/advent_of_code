use std::fs;

pub fn perform() {
    println!("\nDay 3");

    let diagnostics = diagnostics("/Users/nick/Documents/advent/inputs/three");

    part_one(&diagnostics);
    // part_two(&diagnostics);
}

fn diagnostics(path: &str) -> Vec<Vec<u8>> {
    let input: String = fs::read_to_string(path).unwrap();

    input.split('\n').
        map(|s| s.to_string()).
        filter(|s| !s.is_empty()).
        map(|s| s.chars().enumerate().map(|(_i, c)| c.to_digit(10).unwrap() as u8).collect()).
        collect()
}

fn part_one(diagnostics: &[Vec<u8>]) {
    let gamma = gamma_rate(diagnostics);
    let epsilon = gamma.map(|bit| bit ^ 1);

    println!("├ Part one: {:?}", int(gamma) * int(epsilon));
}

fn part_two(diagnostics: &[Vec<u8>]) {
    let gamma = gamma_rate(diagnostics);
    let oxygen = oxygen_rating(diagnostics, gamma[0]);

    println!("├ Part one: {:?}", oxygen);
}

fn gamma_rate(diagnostics: &[Vec<u8>]) -> [u8; 12] {
    diagnostics.iter().fold([0; 12], |mut acc, bits| {
        for (i, bit) in bits.iter().enumerate() {
            acc[i] += *bit as u32
        }

        acc
    }).map(|sum| (sum > (diagnostics.len() as u32 / 2)) as u8)
}

fn oxygen_rating(lines: &[Vec<u8>], index: usize, bit: usize) -> Vec<u8> {
    let counts = lines.iter().fold([0; 2], |mut acc, bits| {
        acc[bits[index] as usize] += 1;

        acc
    });

    let looking_for = (counts[bit] >= counts[bit ^ 1]) as u8;

    let filtered_lines = lines.iter().filter(|bits| bits[index] == looking_for).collect::<Vec<u8>>();

    if index - 1 < 0 {
        return filtered_lines
    } else {
        oxygen_rating(filtered_lines, index - 1, bit)
    }
}

fn int(bit_array: [u8; 12]) -> u32 {
    let bit_string = bit_array.
        map(|d| std::char::from_digit(d as u32, 10).unwrap()).
        iter().collect::<String>();

    u32::from_str_radix(&bit_string, 2).unwrap()
}
