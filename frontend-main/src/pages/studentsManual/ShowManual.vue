<template>
  <v-container>
    <PageTitle title="Handbuch für Lernende" />
    <v-row>
      <v-col>
        <v-text-field
          variant="outlined"
          prepend-inner-icon="mdi-magnify"
          :clearable="true"
          v-model="searchTerm"
        >
        </v-text-field>
      </v-col>
    </v-row>
    <v-row>
      <v-col>
        <Suspense>
          <v-expansion-panels>
            <v-expansion-panel
              v-for="(article, index) in articles"
              :key="index"
              :title="article.title"
              :text="article.content"
            />
          </v-expansion-panels>
        </Suspense>
      </v-col>
    </v-row>
  </v-container>
</template>

<script setup async lang="ts">
import { computed, onActivated, onMounted, reactive, ref } from "vue";
import PageTitle from "@/components/PageTitle.vue";
import { articleApi } from "../../api/articleApi";
import { Article } from "../../models/studentsManual/article";

const searchTerm = ref("");

// const articles = reactive(await articleApi.getAll());

const articles: Article[] = reactive([]);

const filteredArticles = computed(() => {
  return articles.filter((article) => {
    return (
      article.title.toLowerCase().includes(searchTerm.value.toLowerCase()) ||
      article.content.toLowerCase().includes(searchTerm.value.toLowerCase())
    );
  });
});

onMounted(() => {
  fetchData();
});

async function fetchData(): Promise<void> {
  const data = await articleApi.getAll();
  articles.splice(0, articles.length - 1, ...data);
}
</script>
