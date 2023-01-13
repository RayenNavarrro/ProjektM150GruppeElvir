export enum StageActivityType {
  singleChoice = <any>"singleChoice",
  multipleChoice = <any>"multipleChoice",
  textInput = <any>"textInput",
}

export class StageActivity {
  id: string;
  title: string;
  task: string;
  maxPoints: number;
  type: StageActivityType;
  answers: StageActivityAnswer[];

  constructor(
    id: string,
    title: string,
    task: string,
    maxPoints: number,
    type: StageActivityType,
    answers: StageActivityAnswer[]
  ) {
    this.id = id;
    this.title = title;
    this.task = task;
    this.maxPoints = maxPoints;
    this.type = type;
    this.answers = answers;
  }
}

export class StageActivityAnswer {
  id: string;
  answerText: string;
  isCorrect: boolean;

  constructor(id: string, answerText: string, isCorrect: boolean) {
    this.id = id;
    this.answerText = answerText;
    this.isCorrect = isCorrect;
  }
}
