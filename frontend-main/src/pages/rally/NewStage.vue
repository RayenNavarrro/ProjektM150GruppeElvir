<template>
  <v-container>
    <v-row>
      <v-col>
        <h1 class="text-h3">Neue Stage erfassen</h1>
      </v-col>
    </v-row>
    <v-row>
      <v-col cols="12">
        <v-text-field label="Titel der Stage" v-model="title"></v-text-field>
      </v-col>
    </v-row>
    <v-row>
      <v-col cols="12">
        <h2 class="text-h4">Instruktion zum Auffinden der Stage</h2>
        <p>
          Im nachfolgenden Eingabefeld kann die Instruktion zum Auffinden der
          Stage im Markdown-Format erfasst werden. Unterhalb des Eingabefeldes
          wird eine formatierte Vorschau des Eingabe angezeigt.
        </p>
      </v-col>
      <v-col cols="12">
        <v-text-field
          label="Titel der Instruktion"
          v-model="preArrivalInformation.title"
        ></v-text-field>
      </v-col>
      <v-col cols="6">
        <v-textarea
          label="Instruktion..."
          v-model="preArrivalInformation.content"
        ></v-textarea>
      </v-col>
      <v-col cols="6">
        <VueShowdown
          class="markdown-preview"
          :markdown="preArrivalInformation.content"
          :options="{ emoji: true, vueTemplate: true }"
        />
      </v-col>
    </v-row>

    <v-row>
      <v-col cols="12">
        <h2 class="text-h4">Information für die Stage</h2>
        <p>
          Im nachfolgenden Eingabefeld kann der Informationsteil für die
          entsprechende Stage im Markdown-Format erfasst werden. Unterhalb des
          Eingabefeldes wird eine formatierte Vorschau des Eingabe angezeigt.
        </p>
      </v-col>
      <v-col cols="12">
        <v-text-field
          label="Titel der Information"
          v-model="information.title"
        />
      </v-col>
      <v-col cols="6">
        <v-textarea label="Information..." v-model="information.content" />
      </v-col>
      <v-col cols="6">
        <VueShowdown
          class="markdown-preview"
          :markdown="information.content"
          :options="{ emoji: true, vueTemplate: true }"
        />
      </v-col>
    </v-row>

    <v-row>
      <v-col>
        <h2 class="text-h4">Ressourcen</h2>
        <p class="text-body-1">
          Sie können dem Informations-Block verschiedene Ressourcen hinzufügen.
          Diese Ressourcen werden für die Stage zusammen mit dem
          Informations-Block dargestellt.
        </p>
      </v-col>
    </v-row>

    <v-row>
      <v-col>
        <v-btn-toggle v-model="resourceType" tile group>
          <v-btn value="link">
            <v-icon start>mdi-web</v-icon>
            Link
          </v-btn>
          <v-btn value="video">
            <v-icon start>mdi-video</v-icon>
            Video
          </v-btn>
        </v-btn-toggle>
        <v-row>
          <v-col>
            <v-text-field
              v-model="resourceTitle"
              label="Titel"
              prepend-inner-icon="mdi-tag"
            />
          </v-col>
          <v-col>
            <v-text-field
              v-model="resourceUrl"
              label="URL"
              prepend-inner-icon="mdi-link"
            />
          </v-col>
          <v-col>
            <v-btn @click="addAttachment">Ressource hinzufügen</v-btn>
          </v-col>
        </v-row>
      </v-col>
    </v-row>

    <v-row>
      <v-col>
        <v-list>
          <v-list-item
            v-for="(resource, index) in information.attachments"
            :key="index"
            :value="resource"
          >
            <v-list-item-avatar start>
              <v-icon :icon="resourceIcon(resource)" />
            </v-list-item-avatar>
            <v-list-item-title v-text="resource.title" />

            <template v-slot:append>
              <v-spacer />

              <v-btn
                icon
                size="x-small"
                class="mx-2"
                @click="showAttachment(resource)"
              >
                <v-icon size="small">mdi-open-in-new</v-icon>
              </v-btn>
              <v-btn icon size="x-small" @click="removeAttachment(resource)">
                <v-icon size="small">mdi-delete</v-icon>
              </v-btn>
            </template>
          </v-list-item>
        </v-list>
      </v-col>
    </v-row>

    <v-row>
      <v-col>
        <v-btn> Abbrechen </v-btn>
        <v-btn color="primary" @click="submitStage"> Speichern </v-btn>
      </v-col>
    </v-row>
  </v-container>
</template>

<script setup lang="ts">
import { ref, reactive } from "vue";
import { VueShowdown } from "vue-showdown";
import { stageApi } from "../../api/rally/stageApi";
import {
  RallyAttachment,
  RallyAttachmentType,
} from "../../models/rally/rallyAttachment";
import { Stage, StageInformation } from "../../models/rally/stage";

const title = ref("");
const information = reactive(new StageInformation("", "", "", []));
const preArrivalInformation = reactive(new StageInformation("", "", "", []));

const resourceTitle = ref("");
const resourceType = ref("link");
const resourceUrl = ref("");

function addAttachment() {
  const newAttachment = new RallyAttachment(
    "",
    resourceTitle.value,
    resourceUrl.value,
    RallyAttachmentType[resourceType.value as keyof typeof RallyAttachmentType]
  );
  information.attachments.push(newAttachment);
  resourceTitle.value = "";
  resourceUrl.value = "";
}

function removeAttachment(resource: RallyAttachment) {
  const index = information.attachments.indexOf(resource);
  if (index > -1) {
    information.attachments.splice(index, 1);
  }
}

function showAttachment(resource: RallyAttachment) {
  window.open(resource.url, "_blank");
}

function resourceIcon(resource: RallyAttachment): string {
  switch (resource.type) {
    case RallyAttachmentType.link:
      return "mdi-web";
    case RallyAttachmentType.video:
      return "mdi-video";
  }
  return "mdi-web";
}

function submitStage(): void {
  const stageCreationRequestData = {
    title: title.value,
    preArrivalInformation,
    information,
  } as Partial<Stage>;

  stageApi.create(stageCreationRequestData);
}
</script>

<style lang="scss">
.markdown-preview {
  padding: 15px;
  border: 1px solid black;
  border-radius: 5px;

  list-style-position: inside;

  & ul ul {
    margin-left: 1.5em;
  }
}
</style>
