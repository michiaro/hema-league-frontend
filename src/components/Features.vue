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
            />
          </div>
        </div>

        <div class="col col-xl-9">
          <FeatureInfo
            :title="activeFeature"
            :content="activeFeatureContent"
            class="features__feature-info"
          />
        </div>
      </div>
    </div>
  </div>
</template>

<script lang="ts" setup>
import { ref, onMounted, nextTick } from 'vue'
import Feature from './Feature.vue'
import FeatureInfo from './FeatureInfo.vue'

const features = ref([
  {
    title: 'Регулярные турниры',
    content: `<p>В сезоне 2025-2026 нас ждет 9 турниров в каждом дивизионе. Каждый турнир проводится на определенном снаряде. Это не просто отдельные соревнования — мы хотим создать серию мероприятий, которая поможет тебе увидеть свой прогресс за сезон.</p>
    <p>
    Помимо основных турниров, в Лигу войдут командные и личные турниры — “сателлиты”. Их результаты не учитываются в рейтинге, но они отлично подходят для тренировки и набора опыта. 
    </p>
    <p>Мы создали Лигу, чтобы участники могли наслаждаться процессом и получать удовольствие от соревнований. Не зацикливайтесь на победах — главное, чтобы было весело и интересно!</p>`,
  },
  {
    title: '9 снарядов с уникальными рулсетами',
    content: `
    <p>В Лиге есть турниры по трем направлениям: сабля, рапира и длинный меч.</p>
    <p>В каждом из них — по три снаряда с разными правилами, так что можно попробовать что-то новое и понять, что тебе больше по душе.</p>
    <p>Всё, что нужно — зарегистрироваться и начать участвовать. Не стоит бояться сложных правил — главное здесь получать удовольствие от процесса и совершенствоваться по ходу дела.</p>`,
  },
  {
    title: 'Опыт для бойцов любого уровня',
    content: `<p>В Лиге есть три эшелона участников:</p>
      <ul>
        <li>Начинающий. Те, кто только начал фехтовать и занимается менее года (с 2025).</li>
        <li>Начинающий+. Фехтовальщики с опытом до двух лет, выступающие на турнирах с 2024.</li>
        <li>Общий — все остальные, независимо от опыта и количества турниров.</li>
      </ul>
      <p>Все участники соревнуются в общей сетке, но благодаря швейцарской системе ты будешь встречаться с соперниками примерно равного уровня. Мы за честную и интересную борьбу для всех!</p>`,
  },
  {
    title: 'Новая рейтинговая система',
    content: `<p>Рейтинг учитывает количество участников на турнире и твои победы. Так что чем больше у тебя побед, тем выше рейтинг.</p>
    <p>Победители определяются по количеству побед. Медали и призы — приятный бонус, но главное — это твой личный прогресс. Ты сможешь понять свои сильные стороны и ошибки, увидишь свой рост за сезон.</p>
    <p>Для тренеров Лига — инструмент для оценки эффективности тренировочной программы и мотивации участников.</p>`,
  },
  {
    title: 'Уютный локальный формат',
    content: `<p>Все турниры проходят прямо в твоем городе или регионе. Не нужно брать отпуск и далеко ехать, все рядом.</p>
    <p>В сезоне 2025-2026 Лига пройдет в трех дивизионах: Цетр, Урал и Сибирь — специально для фехтовальщиков этих регионов.</p>
    <p>А если ты хочешь отправиться в путешествие и поучаствовать в другом регионе — мы только за!</p>`,
  },
])

const activeFeature = ref('')
const activeFeatureContent = ref('')

function setActiveFeature(title?: string, content?: string) {
  activeFeature.value = title || features.value[0].title
  activeFeatureContent.value = content || features.value[0].content
}

onMounted(() => {
  nextTick(async () => {
    setActiveFeature()
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

  &__feature-info {
    display: none;
    @media screen and (min-width: 1024px) {
      display: block;
    }
  }
}
</style>