use std::fs;

struct Point {
    x: u32,
    y: u32,
    aim: u32
}
struct Command {
    direction: String,
    amount: u32
}

pub fn perform() {
    println!("\nDay 2");

    let commands = commands("/Users/nick/Documents/advent/inputs/two");

    part_one(&commands);
    part_two(&commands);
}

fn commands(path: &str) -> Vec<Command> {
    let input: String = fs::read_to_string(path).unwrap();

    return input.split('\n').
        map(|s| s.to_string()).
        filter(|s| !s.is_empty()).
        map(|s| s.split_whitespace().map(|s| s.to_string()).collect()).
        map(|s: Vec<String>| Command {
            direction: s[0].to_string(),
            amount: s[1].parse::<u32>().unwrap()
        }).
        collect()
}

fn part_one(commands: &[Command]) {
    let coordinate = commands.iter().fold(Point { x: 0, y: 0, aim: 0 }, |mut acc, command| {
        match command.direction.as_str() {
            "forward" => acc.x += command.amount,
            "up" => acc.y -= command.amount,
            "down" => acc.y += command.amount,
            _ => println!("Unknown direction")
        }

        acc
    });

    println!("├ Part one: {:?}", coordinate.x * coordinate.y);
}

fn part_two(commands: &[Command]) {
    let coordinate = commands.iter().fold(Point { x: 0, y: 0, aim: 0 }, |mut acc, command| {
        match command.direction.as_str() {
            "forward" => {
                acc.x += command.amount;
                acc.y += acc.aim * command.amount;
            },
            "up" => acc.aim -= command.amount,
            "down" => acc.aim += command.amount,
            _ => println!("Unknown direction")
        }

        acc
    });

    println!("└ Part two: {:?}", coordinate.x * coordinate.y);
}
