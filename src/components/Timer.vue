<template>
  <div class="timer">
    <div class="timer__title">До регистрации</div>

    <div class="timer__body">
      <span class="timer__time">
        <div class="timer__item timer__item--narrow">
          <span class="timer__number" id="days">{{ days }}</span>
          <div class="timer__caption">дней</div>
        </div>

        <div class="timer__divider">:</div>

        <div class="timer__item timer__item--narrow">
          <span class="timer__number" id="hours"> {{ hours }} </span>
          <div class="timer__caption">часов</div>
        </div>
        <div class="timer__divider">:</div>

        <div class="timer__item timer__item--wide">
          <span class="timer__number" id="minutes"> {{ minutes }} </span>
          <div class="timer__caption">минут</div>
        </div>
        <div class="timer__divider">:</div>

        <div class="timer__item timer__item--wide">
          <span class="timer__number" id="seconds"> {{ seconds }} </span>
          <div class="timer__caption">секунд</div>
        </div>
      </span>
    </div>
  </div>
</template>

<script lang="ts" setup>
import { ref, onMounted } from 'vue'

const days = ref(0)
const hours = ref(0)
const minutes = ref(0)
const seconds = ref(0)

const year = new Date().getFullYear()
const registrationStart = new Date(year, 6, 10).getTime()

const startTimer = () =>
  setInterval(() => {
    const today = new Date().getTime()

    // get the difference
    const diff = registrationStart - today

    const newDays = Math.floor(diff / (1000 * 60 * 60 * 24))
    const newHours = Math.floor((diff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60))
    const newMinutes = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60))
    const newSeconds = Math.floor((diff % (1000 * 60)) / 1000)

    days.value = newDays
    hours.value = newHours
    minutes.value = newMinutes
    seconds.value = newSeconds
  }, 1000)

onMounted(() => {
  const today = new Date().getTime()
  const diff = registrationStart - today

  if (diff > 0) {
    startTimer()
  }
})
</script>


<style lang="scss" scoped>
.timer {
  max-width: 30em;
  margin: auto;
  padding: 0 16px;

  @media screen and (min-width: 800px) {
    max-width: 40em;
  }

  @media screen and (min-width: 1600px) {
    max-width: none;
  }

  &__title {
    font-size: 4.5vw;
    font-weight: bold;
    text-transform: uppercase;
    text-align: center;
    transform: translateY(4px);

    @media screen and (min-width: 560px) {
      font-size: 24px;
    }
    @media screen and (min-width: 1600px) {
      font-size: 42px;
    }
  }
  &__body {
    box-sizing: border-box;
    padding: 12px;
    clip-path: polygon(10% 0, 100% 0, 100% 83%, 90% 100%, 0 100%, 0 17%);
    background-color: var(--color-background-inverted);
    text-align: center;

    @media screen and (min-width: 1600px) {
      width: 1078px;
      height: 230px;
      margin: auto;
      padding: 22px 36px;
    }
  }
  &__time {
  }
  &__item {
    display: inline-block;
    text-align: center;

    &--narrow {
      width: 60px;

      @media screen and (min-width: 560px) {
        width: 80px;
      }
      @media screen and (min-width: 800px) {
        width: 100px;
      }
      @media screen and (min-width: 1600px) {
        width: 180px;
      }
    }
    &--wide {
      width: 80px;

      @media screen and (min-width: 560px) {
        width: 106px;
      }
      @media screen and (min-width: 800px) {
        width: 150px;
      }
      @media screen and (min-width: 1600px) {
        width: 230px;
      }
    }
  }
  &__number {
    font-size: 13vw;
    line-height: 0.97;
    font-family: 'Amaz2';
    margin-bottom: 5px;

    @media screen and (min-width: 560px) {
      font-size: 64px;
    }
    @media screen and (min-width: 800px) {
      font-size: 96px;
    }
    @media screen and (min-width: 1600px) {
      font-size: 150px;
    }
  }
  &__caption {
    font-size: 3vw;

    @media screen and (min-width: 560px) {
      font-size: 16px;
    }
    @media screen and (min-width: 800px) {
      font-size: 18px;
    }
    @media screen and (min-width: 1600px) {
      font-size: 24px;
    }
  }
  &__divider {
    display: inline-block;
    font-family: 'Amaz2';
    font-size: 56px;
    transform: translateY(-35%);

    @media screen and (min-width: 560px) {
      font-size: 64px;
    }
    @media screen and (min-width: 800px) {
      font-size: 96px;
    }
    @media screen and (min-width: 1600px) {
      font-size: 136px;
    }
  }
}
</style>