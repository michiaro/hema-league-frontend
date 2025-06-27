<template>
  <div class="schedule">
    <div class="schedule__border"></div>
    <span class="schedule__tagline">
      <img src="../assets/schedule-tagline.svg" alt="Твой план на сезон" />
    </span>

    <div class="schedule__content">
      <div class="schedule__heading">
        <div class="schedule__title title">Расписание</div>

        <div class="filter">
          <div class="filter__arrows">
            <img src="../assets/arrows.svg" alt="Читай подробнее" />
          </div>

          <div class="filter__inner">
            <div class="filter__title title">Выбери свой дивизион</div>

            <div class="filter__divider divider"></div>

            <div class="filter__list">
              <label class="filter__list-item">
                <input
                  class="filter__checkbox"
                  type="checkbox"
                  name="center"
                  id="center"
                  @change="filter"
                  v-model="showCenter"
                />
                Центр
              </label>
              <label class="filter__list-item">
                <input
                  class="filter__checkbox"
                  type="checkbox"
                  name="ural"
                  id="ural"
                  @change="filter"
                  v-model="showUral"
                />
                Урал
              </label>
              <label class="filter__list-item">
                <input
                  class="filter__checkbox"
                  type="checkbox"
                  name="syberia"
                  id="syberia"
                  @change="filter"
                  v-model="showSyberia"
                />
                Сибирь
              </label>
            </div>
          </div>
        </div>
      </div>

      <div class="container container-fluid">
        <div class="row">
          <div class="col col-xs-12 col-md-8 col-md-offset-2">
            <div class="schedule__tournament-list">
              <Tournament
                v-for="tournament in filteredTournamentList"
                :key="tournament.id"
                :tournament="tournament"
              />
            </div>

            <div class="schedule__empty-text" v-if="filteredTournamentList.length < 1">
              Выбери хотя бы один дивизион, чтобы просмотреть турниры
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>


<script lang="ts" setup>
import { onMounted } from 'vue'

import Tournament from './Tournament.vue'
import { computed, ref } from 'vue'
import { tournaments } from '../tournaments'

const tournamentList = ref(tournaments)
const filteredTournamentList = ref(tournamentList)

const showCenter = defineModel('center', { default: true })
const showUral = defineModel('ural', { default: true })
const showSyberia = defineModel('syberia', { default: true })

const filter = () => {
  filteredTournamentList.value = tournaments.filter(
    (tournament) =>
      (tournament.division === 'Урал' && showUral.value) ||
      (tournament.division === 'Центр' && showCenter.value) ||
      (tournament.division === 'Сибирь' && showSyberia.value)
  )
}

onMounted(() => {
  filter()
})
</script>

<style lang="scss" scoped>
.schedule {
  position: relative;
  margin-top: 28px;
  overflow: hidden;

  &__heading {
    padding-top: 28px;
    margin: 0 16px 28px;
    display: flex;
    flex-flow: row wrap;
    justify-content: space-between;

    @media screen and (min-width: 1400px) {
      margin: auto;
      max-width: 90vw;
      justify-content: space-between;
      margin-bottom: 56px;
    }
  }

  &__content {
    background-color: var(--color-background-contrast);
    color: var(--color-text-contrast);
    padding-bottom: 54px;
  }

  &__title {
    font-size: 36px;

    @media screen and (min-width: 1024px) {
      font-size: 74px;
    }
  }
  &__tagline {
    position: absolute;
    top: 38px;
    right: 0;

    @media screen and (min-width: 1024px) {
      top: 0;
      left: 0;
      right: auto;
      transform: rotate(-90deg) translate(-100%, -50%);
    }

    @media screen and (min-width: 1200px) {
      transform: rotate(-90deg) translate(-83%, -50%);
    }
    @media screen and (min-width: 1400px) {
      transform: rotate(-90deg) translate(-71%, -57%);
    }
    @media screen and (min-width: 1900px) {
      transform: rotate(-90deg) translate(-62%, -58%);
    }

    img {
      width: 180px;

      @media screen and (min-width: 1024px) {
        width: 360px;
      }
      @media screen and (min-width: 1200px) {
        width: 440px;
      }
      @media screen and (min-width: 1400px) {
        width: 600px;
      }
      @media screen and (min-width: 1600px) {
        width: 650px;
      }
      @media screen and (min-width: 1900px) {
        width: 790px;
      }
    }
  }

  &__tournament-list {
  }
  &__border {
    position: relative;
    height: 90px;

    &::after {
      position: absolute;
      content: '';
      width: 0;
      height: 0;
      border-left: 100vw solid transparent;
      border-bottom: 91px solid var(--color-background-contrast);
    }
  }

  &__empty-text {
    font-size: 24px;
    text-align: center;
    margin: 20px;
  }
}

.filter {
  margin-left: auto;
  margin-top: 16px;

  @media screen and (min-width: 560px) {
    margin-top: 0;
  }
  @media screen and (min-width: 1024px) {
    display: flex;
    margin: 0;
    padding-top: 24px;
  }

  &__arrows {
    display: none;

    @media screen and (min-width: 1200px) {
      display: block;
      width: 99px;
      padding-top: 2px;
      margin-right: 32px;
    }

    img {
      width: 100%;
    }
  }

  &__inner {
    max-width: 290px;

    @media screen and (min-width: 1024px) {
      max-width: 425px;
    }
    // TODO
    // @media screen and (min-width: 1900px) {
    // position: sticky;
    // top: 100px;

    // inset-block-start: 3px;
    // inset-inline-end: 3px;
    // }
  }

  &__title {
    font-size: 24px;
    text-align: right;

    @media screen and (min-width: 1024px) {
      font-size: 36px;
    }
  }
  &__divider {
  }
  &__list {
    display: flex;
    justify-content: space-between;
    margin-top: 10px;
  }
  &__list-item {
    font-size: 14px;
    cursor: pointer;

    @media screen and (min-width: 1024px) {
      font-size: 24px;
    }
  }
  &__checkbox {
    cursor: pointer;
    -webkit-appearance: none;
    appearance: none;
    background-color: var(--color-background-contrast);
    margin: 0;

    font: inherit;
    color: var(--color-background);
    width: 14px;
    height: 14px;
    border: 2px solid var(--color-background);
    border-radius: 0;
    vertical-align: top;
    margin-right: 8px;

    @media screen and (min-width: 1024px) {
      width: 23px;
      height: 23px;
      margin-right: 12px;
    }

    &::before {
      position: absolute;
      content: '';
      width: 0.65em;
      height: 0.65em;
      transform: scale(0) rotate(11deg);
      transition: 120ms transform ease-in-out;
      box-shadow: inset 1em 1em var(--color-background);

      transform-origin: bottom left;
      clip-path: polygon(14% 44%, 0 65%, 50% 100%, 100% 16%, 80% 0%, 43% 62%);
    }

    &:checked::before {
      transform: scale(1) rotate(11deg);
    }
  }
}
</style>