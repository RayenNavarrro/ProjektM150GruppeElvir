import type { RouteRecordRaw } from "vue-router";
import { createRouter, createWebHistory } from "vue-router";

import Home from "@/pages/Home.vue";
import HelloWorld from '@/components/Helloworld.vue';
import ShowManual from "@/pages/studentsManual/ShowManual.vue";
import NewArticle from "@/pages/studentsManual/NewArticle.vue";
import ListStages from "@/pages/rally/ListStages.vue";
import NewStage from "@/pages/rally/NewStage.vue";
import ShowStage from "@/pages/rally/ShowStage.vue";
import ListRallies from "@/pages/rally/ListRallies.vue";
import NewRally from "@/pages/rally/NewRally.vue";
import ShowRally from "@/pages/rally/ShowRally.vue";
import NewRallyStage from "@/pages/rally/NewRallyStage.vue";
import ShowRallyStage from "@/pages/rally/ShowRallyStage.vue";
import ShowConstraint from "@/pages/rally/ShowConstraint.vue";

const routes: Array<RouteRecordRaw> = [
    {
        path: "/",
        name: "Home",
        component: Home,
    },
    {
        path: '/hello',
        name: 'Hello World',
        component: HelloWorld
    },
    {
        path: "/students-manual",
        name: "Students manual",
        component: ShowManual,
    },
    {
        path: "/students-manual/new-article",
        name: "New article",
        component: NewArticle,
    },
    {
        path: "/rally/stages",
        name: "List stages",
        component: ListStages,
    },
    {
        path: "/rally/new-stage",
        name: "New stage",
        component: NewStage,
    },
    {
        path: "/rally/stage/:stageId",
        name: "Show stage",
        component: ShowStage,
        props: true,
    },
    {
        path: "/rally/rallies",
        name: "List rallies",
        component: ListRallies,
    },
    {
        path: "/rally/new-rally",
        name: "New rally",
        component: NewRally,
    },
    {
        path: "/rally/rally/:rallyId",
        name: "Show rally",
        component: ShowRally,
        props: true,
    },
    {
        path: "/rally/rally/:rallyId/add-stage",
        name: "Add rallyStage",
        component: NewRallyStage,
        props: true,
    },
    {
        path: "/rally/rally/:rallyId/stage/:rallyStageId",
        name: "Show rallyStage",
        component: ShowRallyStage,
        props: true,
    },
    {
        path: "/rally/rally/:rallyId/stage/:rallyStageId/constraint/:constraintId",
        name: "Show constraint",
        component: ShowConstraint,
        props: true,
    },
];

const router = createRouter({
    history: createWebHistory(),
    routes,
});

export default router;