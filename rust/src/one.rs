use std::fs;

pub fn perform() {
    println!("\n=== DAY ONE ===\n");

    let measurements = measurements("/Users/nick/Documents/advent/inputs/one");

    println!("Part one increases: {:?}", collect_increases(&measurements, 1));
    println!("Part two increases: {:?}", collect_increases(&measurements, 3));
}

fn measurements(path: &str) -> Vec<String> {
    let input: String = fs::read_to_string(path).unwrap();

    return input.split('\n').map(|s| s.to_string()).filter(|s| !s.is_empty()).collect()
}

fn to_number(measurement: &str) -> u32 {
    measurement.to_string().parse().unwrap()
}

fn window_sum(measurements: &[String], index: usize, window: usize) -> u32 {
    measurements[index .. (index + window)].iter().map(|m| to_number(m)).sum()
}

fn collect_increases(measurements: &[String], window: usize) -> u32 {
    let mut increase_count = 0;

    for index in 0..(measurements.len() - window) {
        let previous = window_sum(&measurements, index, window);
        let current = window_sum(&measurements, index + 1, window);

        if previous < current {
            increase_count += 1;
        }
    }

    increase_count
}
