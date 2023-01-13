export class Assignment {
  id: string;
  joiningCode: number;
  audience: Audience;

  constructor(id: string, joiningCode: number, audience: Audience) {
    this.id = id;
    this.joiningCode = joiningCode;
    this.audience = audience;
  }
}

export class Audience {
  id: string;
  title: string;
  participatingParties: ParticipatingParty[];

  constructor(
    id: string,
    title: string,
    participatingParties: ParticipatingParty[]
  ) {
    this.id = id;
    this.title = title;
    this.participatingParties = participatingParties;
  }
}

export class ParticipatingParty {
  id: string;
  title: string;

  constructor(id: string, title: string) {
    this.id = id;
    this.title = title;
  }
}
