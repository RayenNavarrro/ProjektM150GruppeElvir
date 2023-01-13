import { Assignment } from "./assignment";

export class Rally {
  id: string;
  title: string;
  rallyStages: RallyStage[];
  assignments: Assignment[];

  constructor(
    id: string,
    title: string,
    rallyStages: RallyStage[],
    assignments: Assignment[]
  ) {
    this.id = id;
    this.title = title;
    this.rallyStages = rallyStages;
    this.assignments = assignments;
  }
}

export class RallyStage {
  id: string;
  rallyId: string;
  stageId: string;
  constraints: Constraint[];

  constructor(
    id: string,
    rallyId: string,
    stageId: string,
    constraints: Constraint[]
  ) {
    this.id = id;
    this.rallyId = rallyId;
    this.stageId = stageId;
    this.constraints = constraints;
  }
}

export abstract class Constraint {
  id: string;
  type: string;
  conditions: Condition[];

  constructor(id: string, type: string, conditions: Condition[]) {
    this.id = id;
    this.type = type;
    this.conditions = conditions;
  }

  static BuildConstraint(
    type: string,
    conditions: Condition[],
    rallyStageId: string | null = null,
    immediate: boolean | null = null
  ): Constraint {
    switch (type) {
      case "entryPoint":
        return new EntryPointConstraint("", conditions);
      case "predecessor":
        if (rallyStageId == null || immediate == null) {
          throw new Error(
            "Cannot build concrete instance of type Constraint due to invalid arguments."
          );
        }
        return new PredecessorConstraint(
          "",
          conditions,
          rallyStageId!,
          immediate!
        );
      case "successor":
        if (rallyStageId == null) {
          throw new Error(
            "Cannot build concrete instance of type Constraint due to invalid arguments."
          );
        }
        return new SuccessorConstraint("", conditions, rallyStageId!);
      case "terminal":
        return new TerminalConstraint("", conditions);
      default:
        throw new Error(
          "Cannot build concrete instance of type Constraint due to invalid arguments."
        );
    }
  }
}

export class EntryPointConstraint extends Constraint {
  constructor(id: string, conditions: Condition[]) {
    super(id, "entryPoint", conditions);
  }
}
export class PredecessorConstraint extends Constraint {
  predecessorId: string;
  immediate: boolean;

  constructor(
    id: string,
    conditions: Condition[],
    predecessorId: string,
    immediate: boolean
  ) {
    super(id, "predecessor", conditions);
    this.predecessorId = predecessorId;
    this.immediate = immediate;
  }
}

export class SuccessorConstraint extends Constraint {
  successorId: string;

  constructor(id: string, conditions: Condition[], successorId: string) {
    super(id, "successor", conditions);
    this.successorId = successorId;
  }
}

export class TerminalConstraint extends Constraint {
  constructor(id: string, conditions: Condition[]) {
    super(id, "terminal", conditions);
  }
}

export abstract class Condition {
  id: string;
  matchingType: ConditionMatchingType;

  constructor(id: string, matchingType: ConditionMatchingType) {
    this.id = id;
    this.matchingType = matchingType;
  }
}

export class LocationCondition extends Condition {
  locationId: string;

  constructor(
    id: string,
    matchingType: ConditionMatchingType,
    locationId: string
  ) {
    super(id, matchingType);
    this.locationId = locationId;
  }
}

export class StageCondition extends Condition {
  stageId: string;

  constructor(
    id: string,
    matchingType: ConditionMatchingType,
    stageId: string
  ) {
    super(id, matchingType);
    this.stageId = stageId;
  }
}

export enum ConditionMatchingType {
  positiveMatch = <any>0,
  negativeMatch = <any>1,
}
