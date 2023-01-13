<template>
  <v-container>
    <v-row>
      <v-col>
        <h1 class="text-h3">Stages</h1>
      </v-col>
    </v-row>

    <v-row>
      <v-col>
        <v-table fixed-header>
          <thead>
            <tr>
              <th class="text-left">Titel</th>
              <th class="text-left">Informations-Block</th>
              <th class="text-left">Externe Links</th>
              <th class="text-left">Videos</th>
              <th class="text-left">PDFs</th>
            </tr>
          </thead>
          <tbody>
            <tr
              v-for="stage in stages"
              :key="stage.id"
              @click="showStage(stage)"
            >
              <td>{{ stage.title }}</td>
              <td>{{ stage.information.title }}</td>
              <td>
                {{
                  stage.information.attachments.filter(
                    (a) => a.type == RallyAttachmentType.link
                  ).length
                }}
              </td>
              <td>
                {{
                  stage.information.attachments.filter(
                    (a) => a.type == RallyAttachmentType.video
                  ).length
                }}
              </td>
              <td>
                {{
                  stage.information.attachments.filter(
                    (a) => a.type == RallyAttachmentType.pdf
                  ).length
                }}
              </td>
            </tr>
          </tbody>
        </v-table>
      </v-col>
    </v-row>

    <v-row>
      <v-col class="text-center">
        <v-btn :to="{ name: 'New stage' }" color="primary"
          >Stage erstellen</v-btn
        >
      </v-col>
    </v-row>
  </v-container>
</template>

<script setup lang="ts">
import { onMounted, reactive } from "vue";
import { stageApi } from "../../api/rally/stageApi";
import { RallyAttachmentType } from "../../models/rally/rallyAttachment";
import { Stage } from "../../models/rally/stage";
import router from "../../plugins/router";

const stages: Stage[] = reactive([]);

onMounted(() => {
  fetchData();
});

async function fetchData(): Promise<void> {
  var stageData = await stageApi.getAll();
  stages.splice(0, stages.length - 1, ...stageData);
}

function showStage(stage: Stage): void {
  router.push({ name: "Show stage", params: { stageId: stage.id } });
}
</script>

<style lang="scss"></style>
