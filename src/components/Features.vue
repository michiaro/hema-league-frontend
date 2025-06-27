<template>
  <div class="features">
    <div class="features__arrows">
      <img src="../assets/half-arrows-black.svg" alt="Листай дальше" />
    </div>

    <div class="container container-fluid">
      <div class="row">
        <div class="col col-xs-12">
          <h2 class="features__title title">Что такое HEMA League?</h2>
        </div>

        <div class="col col-xs-12 col-xl-3">
          <div class="features__list">
            <Feature
              v-for="feature in features"
              :key="feature.title"
              :class="['feature', { 'feature--active': feature.title === activeFeature }]"
              @onToggle="(title, content) => setActiveFeature(title, content)"
              :title="feature.title"
              :content="feature.content"
              :is-active="feature.title === activeFeature"
              :is-mobile="isMobile"
            />
          </div>
        </div>

        <div class="col col-xl-9" v-if="!isMobile">
          <FeatureInfo :title="activeFeature" :content="activeFeatureContent" />
        </div>
      </div>
    </div>
  </div>
</template>

<script lang="ts" setup>
import { ref, computed, onMounted, nextTick } from 'vue'
import Feature from './Feature.vue'
import FeatureInfo from './FeatureInfo.vue'

const features = ref([
  {
    title: 'Регулярные турниры',
    content: `<p>В Лиге есть три эшелона участников:</p>
  <ul>
    <li>Начинающий. Те, кто только начал фехтовать и занимается менее года (с 2025).</li>
    <li>Начинающий+. Фехтовальщики с опытом до двух лет, выступающие на турнирах с 2024.</li>
    <li>Общий — все остальные, независимо от опыта и количества турниров.</li>
  </ul>
  <p>Все участники соревнуются в общей сетке, но благодаря швейцарской системе ты будешь встречаться с соперниками примерно равного уровня. Мы за честную и интересную борьбу для всех!</p>`,
  },
  {
    title: '9 снарядов с уникальными рулсетами',
    content: `В Лиге есть три эшелона участников:
Начинающий. Те, кто только начал фехтовать и занимается менее года (с 2025).
Начинающий+. Фехтовальщики с опытом до двух лет, выступающие на турнирах с 2024.
Общий — все остальные, независимо от опыта и количества турниров.
Все участники соревнуются в общей сетке, но благодаря швейцарской системе ты будешь встречаться с соперниками примерно равного уровня. Мы за честную и интересную борьбу для всех!`,
  },
  {
    title: 'Опыт для бойцов любого уровня',
    content: `В Лиге есть три эшелона участников:
Начинающий. Те, кто только начал фехтовать и занимается менее года (с 2025).
Начинающий+. Фехтовальщики с опытом до двух лет, выступающие на турнирах с 2024.
Общий — все остальные, независимо от опыта и количества турниров.
Все участники соревнуются в общей сетке, но благодаря швейцарской системе ты будешь встречаться с соперниками примерно равного уровня. Мы за честную и интересную борьбу для всех!`,
  },
  {
    title: 'Новая рейтинговая система',
    content: `В Лиге есть три эшелона участников:
Начинающий. Те, кто только начал фехтовать и занимается менее года (с 2025).
Начинающий+. Фехтовальщики с опытом до двух лет, выступающие на турнирах с 2024.
Общий — все остальные, независимо от опыта и количества турниров.
Все участники соревнуются в общей сетке, но благодаря швейцарской системе ты будешь встречаться с соперниками примерно равного уровня. Мы за честную и интересную борьбу для всех!`,
  },
  {
    title: 'Уютный локальный формат',
    content: `В Лиге есть три эшелона участников:
Начинающий. Те, кто только начал фехтовать и занимается менее года (с 2025).
Начинающий+. Фехтовальщики с опытом до двух лет, выступающие на турнирах с 2024.
Общий — все остальные, независимо от опыта и количества турниров.
Все участники соревнуются в общей сетке, но благодаря швейцарской системе ты будешь встречаться с соперниками примерно равного уровня. Мы за честную и интересную борьбу для всех!`,
  },
])

const activeFeature = ref(null)
const activeFeatureContent = ref(null)

const isMobile = computed(() => {
  return window.innerWidth < 1024
})

function setActiveFeature(title: string, content: string) {
  console.log('isMobile.value', isMobile.value)
  console.log('setActiveFeature', 'title: ', title, 'content: ', content)

  if (!!isMobile.value) {
    activeFeature.value = activeFeature.value === title ? '' : title
  } else {
    activeFeature.value = title
    activeFeatureContent.value = content
  }
}

onMounted(() => {
  nextTick(async () => {
    if (!isMobile.value) {
      const { title, content } = features.value[0]
      setActiveFeature(title, content)
    }
  })
})
</script>

<style lang="scss" scoped>
.features {
  position: relative;
  padding-top: 64px;

  @media screen and (min-width: 1024px) {
    padding-top: 74px;
  }

  @media screen and (min-width: 1400px) {
    padding-top: 156px;
  }

  &__title {
    font-size: 32px;
    margin-bottom: 32px;

    @media screen and (min-width: 1024px) {
      font-size: 74px;
      margin-bottom: 64px;
    }
  }
  &__list {
  }
  &__arrows {
    position: absolute;
    top: 0;
    right: 6px;

    img {
      width: 100%;
    }

    @media screen and (min-width: 1400px) {
      width: 609px;
    }
  }
}
</style>