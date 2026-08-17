class_name Difficulties
extends RefCounted


enum ENUM {
	STAR,
	UNBEATABLE,
	HARD,
	NORMAL,
	EASY,
	BEGINNER,
}


const NAMES: Dictionary[ENUM, String] = {
	ENUM.STAR: "Star",
	ENUM.UNBEATABLE: "UNBEATABLE",
	ENUM.HARD: "Hard",
	ENUM.NORMAL: "Normal",
	ENUM.EASY: "Easy",
	ENUM.BEGINNER: "Beginner"
}
