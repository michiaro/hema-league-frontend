<template>
  <div class="feature-info">
    <div class="feature-info__arrows">
      <img src="../assets/arrows.svg" alt="Читай подробнее" />
    </div>
    <div class="feature-info__content">
      <div class="feature-info__title title" v-if="title">
        {{ glueUpPrepositions(title) }}
      </div>
      <div class="feature-info__text" v-if="content" v-html="glueUpPrepositions(content)" />
    </div>
  </div>
</template>

<script lang="ts" setup>
import { glueUpPrepositions } from '../utils'

defineProps({
  title: String,
  content: String,
})
</script>

<style lang="scss" scoped>
.feature-info {
  height: 100%;
  box-sizing: border-box;

  background-image: url('../assets/feature-background.png');
  background-position: top right;
  background-size: contain;
  background-repeat: no-repeat;

  padding: 38px;
  color: var(--color-text-contrast);
  background-color: var(--color-background-contrast);

  display: flex;
  flex-flow: row nowrap;
  align-items: flex-start;
  column-gap: 24px;

  @media screen and (min-width: 1400px) {
    padding: 38px 28px;
  }

  &__arrows {
    display: none;
    @media screen and (min-width: 1400px) {
      display: block;
      padding-top: 10px;
      max-width: 50%;
    }
  }

  &__content {
    @media screen and (min-width: 1400px) {
      max-width: 66%;
    }
    @media screen and (min-width: 1600px) {
      max-width: 50%;
    }
  }
  &__title {
    line-height: 1.1;
    font-size: 42px;
    margin-bottom: 36px;

    @media screen and (min-width: 1024px) {
      max-width: 430px;
    }
  }

  &__text {
    font-size: 18px;
    line-height: 1.3;

    @media screen and (min-width: 1600px) {
      font-size: 24px;
    }

    * {
      margin: 0;
    }
    * + * {
      margin-top: 10px;
    }
    p {
      margin: 0 0 10px;
    }
    ul {
      padding-left: 22px;
    }
  }
}
</style>