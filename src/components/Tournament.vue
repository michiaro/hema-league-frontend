<template>
  <div class="tournament" v-if="!!tournament">
    <div class="tournament__inner">
      <div class="tournament__date">
        <div :class="['tournament__day', { 'tournament__day--small': tournament.weekend }]">
          {{ day }}
        </div>
        <div class="tournament__month">
          {{ month }}
        </div>
        <div class="tournament__year">
          {{ year }}
        </div>
      </div>

      <div class="tournament__info">
        <div class="tournament__title title">
          {{ tournament.title ? tournament.title : tournament.nomination }}

          <a
            v-if="tournament.link"
            :href="tournament.link"
            target="_blank"
            class="tournament__link"
            title="Перейти на страницу турнира"
          >
            <IconLink />
          </a>
        </div>

        <div v-if="tournament.title" class="tournament__nomination">
          {{ tournament.nomination }}
        </div>

        <div class="tournament__ages">
          <span v-for="(age, ageIndex) in tournament.ages" :key="age" class="tournament__age">
            {{ age + (ageIndex + 1 < tournament.ages.length ? ', ' : '') }}
          </span>
        </div>

        <div class="tournament__echelons" v-if="!tournament.satellite">
          <div v-for="echelon in tournament.echelons" :key="echelon" class="tournament__echelon">
            <span class="tournament__echelon-stars">
              <IconStar
                v-for="index in starCount(echelon)"
                :key="index"
                class="tournament__echelon-star"
              />
            </span>
            {{ echelon }}
          </div>
        </div>

        <div class="tournament__satellite" v-else>
          Результаты не учитываются при&nbsp;подсчете рейтинга
        </div>

        <div class="tournament__city">
          <IconLocation clsas="tournament__city-icon" />
          {{ tournament.city }}
        </div>
      </div>
    </div>
  </div>
</template>


<script lang="ts" setup>
import { computed, ref } from 'vue'
import IconStar from './icons/IconStar.vue'
import IconLocation from './icons/IconLocation.vue'
import IconLink from './icons/IconLink.vue'

const props = defineProps({
  tournament: Object,
})

const starCount = (echelon: string) => {
  switch (echelon) {
    case 'Начинающие':
      return 1
    case 'Начинающие+':
      return 2
    case 'Общий':
      return 3

    default:
      return 1
  }
}

const day = computed(() => {
  return props.tournament?.date.split(' ')[0]
})

const month = computed(() => {
  return props.tournament?.date.split(' ')[1]
})

const year = computed(() => {
  return props.tournament?.date.split(' ')[2]
})
</script>

<style lang="scss" scoped>
.tournament {
  position: relative;
  clip-path: polygon(10% 0, 100% 0, 100% 83%, 90% 100%, 0 100%, 0 17%);
  border: none;
  box-sizing: border-box;
  background: var(--color-background-contrast-light);

  &::before {
    position: absolute;
    z-index: 0;
    content: '';
    top: 3px;
    right: 3px;
    bottom: 3px;
    left: 3px;
    clip-path: polygon(10% 0, 100% 0, 100% 83%, 90% 100%, 0 100%, 0 17%);
    background: linear-gradient(
      95.81deg,
      var(--color-background-contrast) 11.6%,
      var(--color-background-contrast-dark) 121.06%
    );
  }

  & + & {
    margin-top: 24px;

    @media screen and (min-width: 1024px) {
      margin-top: 36px;
    }
  }

  &__inner {
    position: relative;
    z-index: 1;
    display: flex;
    min-height: 200px;
  }

  &__date {
    width: 75px;
    width: 75px;
    text-align: center;
    line-height: 0.97;
    padding: 20px 0 20px 22px;
    box-sizing: border-box;

    @media screen and (min-width: 800px) {
      background-color: var(--color-background-contrast-light);
      min-width: 144px;
      max-width: 144px;
      padding: 20px;
      display: flex;
      flex-flow: column nowrap;
      justify-content: center;
    }
    @media screen and (min-width: 1400px) {
      min-width: 255px;
      max-width: 255px;
    }
    @media screen and (min-width: 1600px) {
      min-width: 272px;
      max-width: 272px;
    }
  }

  &__day {
    font-family: 'Amaz2';
    font-size: 46px;
    color: var(--color-text-contrast);
    margin-bottom: 2px;

    @media screen and (min-width: 800px) {
      color: var(--color-background-contrast);
      font-size: 58px;
    }
    @media screen and (min-width: 1400px) {
      font-size: 106px;
    }

    &--small {
      font-size: 24px;

      @media screen and (min-width: 800px) {
        font-size: 32px;
      }

      @media screen and (min-width: 1400px) {
        font-size: 74px;
      }
    }
  }

  &__month {
    font-size: 14px;
    margin-bottom: 8px;
    color: var(--color-background-contrast-light);
    font-weight: bold;

    @media screen and (min-width: 800px) {
      color: var(--color-background-contrast);
      font-size: 16px;
    }
    @media screen and (min-width: 1400px) {
      font-size: 24px;
    }
  }

  &__year {
    font-family: 'Amaz2';
    font-size: 24px;
    color: var(--color-background-contrast-light);

    @media screen and (min-width: 800px) {
      color: var(--color-text);
      font-size: 32px;
    }
    @media screen and (min-width: 1400px) {
      font-size: 48px;
    }
  }

  &__info {
    // margin-left: 16px;
    padding: 20px 24px 20px 28px;
    width: 100%;

    @media screen and (min-width: 800px) {
      // margin-left: 16px;
    }
    @media screen and (min-width: 1400px) {
      font-size: 24px;
      padding: 26px 40px 32px 32px;
    }
    @media screen and (min-width: 1600px) {
      padding: 48px 40px 60px 32px;
    }
  }
  &__title {
    font-size: 24px;
    margin-bottom: 12px;

    @media screen and (min-width: 1400px) {
      font-size: 36px;
      margin-bottom: 24px;
    }
  }
  &__link {
    margin-left: 10px;

    @media screen and (min-width: 1400px) {
      margin-left: 16px;
    }

    svg {
      width: 18px;
      height: 18px;

      @media screen and (min-width: 1400px) {
        width: 27px;
        height: 27px;
      }
    }
  }
  &__nomination {
    margin-bottom: 10px;

    @media screen and (min-width: 1400px) {
      margin-bottom: 16px;
    }
  }
  &__ages {
  }
  &__age {
  }
  &__echelons {
    margin-top: 10px;

    @media screen and (min-width: 1400px) {
      margin-top: 10px;
      display: flex;
      align-items: baseline;
      flex-wrap: wrap;
    }
  }
  &__echelon {
    @media screen and (min-width: 1400px) {
      margin-right: 30px;
    }

    & + & {
      margin-top: 8px;

      @media screen and (min-width: 1400px) {
        margin-top: 10px;
      }
    }
  }
  &__echelon-stars {
    margin-right: 8px;
  }
  &__echelon-star {
    @media screen and (min-width: 1400px) {
      width: 16px;
      height: 15px;
    }

    & + & {
      margin-left: 3px;
    }
  }

  &__satellite {
    margin-top: 10px;

    @media screen and (min-width: 1400px) {
      margin-top: 16px;
    }
  }
  &__city {
    margin-top: 10px;
    padding-top: 10px;

    border-top: 2px solid var(--color-background-contrast-light);

    @media screen and (min-width: 1400px) {
      margin-top: 16px;
      padding-top: 16px;
    }

    svg {
      margin-right: 8px;
      width: 12px;
      height: 14px;

      @media screen and (min-width: 1400px) {
        width: 16px;
        height: 19px;
      }
    }
  }
}
</style>