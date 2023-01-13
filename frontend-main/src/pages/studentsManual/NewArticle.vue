<template>
  <v-container>
    <v-row>
      <v-col>
        <h1 class="text-h3">Neuen Artikel erfassen</h1>
      </v-col>
    </v-row>
    <v-row>
      <v-col>
        <v-text-field label="Titel des Artikels" v-model="title"></v-text-field>
      </v-col>
    </v-row>
    <v-row>
      <v-col cols="12">
        <p class="text-body-1">
          Im nachfolgenden Eingabefeld kann der Inhalt des Artikels mit Markdown
          erfasst werden. Unterhalb des Eingabefeldes wird eine formatierte
          Vorschau des Artikels angezeigt.
        </p>
      </v-col>
    </v-row>
    <v-row>
      <v-col>
        <v-textarea v-model="content"></v-textarea>
      </v-col>
    </v-row>
    <v-row>
      <v-col>
        <VueShowdown
          id="markdown-preview"
          :markdown="content"
          :options="{ emoji: true, vueTemplate: true }"
        />
      </v-col>
    </v-row>

    <v-row>
      <v-col>
        <h2 class="text-h4">Ressourcen</h2>
        <p class="text-body-1">
          Sie können dem Artikel verschiedene Ressourcen hinzufügen. Diese
          Ressourcen werden im Handbuch zusammen mit dem eigentlichen Artikel
          dargestellt.
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
          <v-btn value="pdf">
            <v-icon start>mdi-file-document-outline</v-icon>
            PDF
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
            v-for="(resource, index) in attachments"
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
        <v-btn color="primary" @click="submitArticle"> Speichern </v-btn>
      </v-col>
    </v-row>
  </v-container>
</template>

<script setup lang="ts">
import { ref, reactive } from "vue";
import { VueShowdown } from "vue-showdown";
import { articleApi } from "../../api/articleApi";
import { Article } from "../../models/studentsManual/article";
import {
  Attachment,
  AttachmentType,
} from "../../models/studentsManual/articleResource";

const title = ref("Ein beliebiger Titel");
const content = ref("");
const resourceTitle = ref("");
const resourceType = ref("link");
const resourceUrl = ref("");

const attachments: Attachment[] = reactive([]);

function addAttachment() {
  const newAttachment = new Attachment(
    "",
    resourceTitle.value,
    resourceUrl.value,
    AttachmentType[resourceType.value as keyof typeof AttachmentType]
  );
  attachments.push(newAttachment);
  resourceTitle.value = "";
  resourceUrl.value = "";
}

function removeAttachment(resource: Attachment) {
  const index = attachments.indexOf(resource);
  if (index > -1) {
    attachments.splice(index, 1);
  }
}

function showAttachment(resource: Attachment) {
  window.open(resource.url, "_blank");
}

function resourceIcon(resource: Attachment): string {
  switch (resource.type) {
    case AttachmentType.link:
      return "mdi-web";
    case AttachmentType.video:
      return "mdi-video";
    case AttachmentType.pdf:
      return "mdi-file-document-outline";
  }
  return "mdi-web";
}

function submitArticle(): void {
  const articleCreationRequestData = {
    title: title.value,
    content: content.value,
    attachments: attachments,
    tags: [],
  };
  articleApi.create(articleCreationRequestData);
}
</script>

<style lang="scss">
#markdown-preview {
  padding: 15px;
  border: 1px solid black;
  border-radius: 5px;

  list-style-position: inside;

  & ul ul {
    margin-left: 1.5em;
  }
}
</style>
