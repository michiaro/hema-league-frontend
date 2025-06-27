<template>
  <div class="feature">
    <div
      :class="['feature__heading', { 'feature__heading--active': isActive }]"
      @click="$emit('onToggle', title, content)"
    >
      <div class="feature__title title">{{ glueUpPrepositions(title) }}</div>
      <img class="feature__arrows" src="../assets/half-arrows.svg" alt="Открыть" />

      <span class="feature__pointer" v-show="isActive"> </span>
    </div>

    <div class="feature__content" v-if="isMobile && isActive">
      <div class="feature__close" @click="$emit('onToggle', title, content)">
        <img src="../assets/close.svg" alt="Закрыть" />
      </div>

      <div class="feature__text" v-html="content" />
    </div>
  </div>
</template>

<script lang="ts" setup>
import { ref, reactive } from 'vue'
import { glueUpPrepositions } from '../utils'

defineProps({
  title: String,
  content: String,
  isActive: Boolean,
  isMobile: Boolean,
})
</script>

<style lang="scss" scoped>
.feature {
  $feature: &;

  & + & {
    margin-top: 10px;

    @media screen and (min-width: 1024px) {
      margin-top: 14px;
    }
  }
  &__heading {
    cursor: pointer;
    position: relative;
    width: 100%;
    box-sizing: border-box;
    padding: 16px 12px;
    background-color: var(--color-background-contrast-light);

    @media screen and (min-width: 1400px) {
      padding: 18px 26px;
    }

    &--active {
      background-color: var(--color-background-contrast);

      #{$feature}__title {
        color: var(--color-text-contrast);
      }
    }
  }
  &__title {
    line-height: 1.1;
    font-size: 24px;

    @media screen and (min-width: 1024px) {
      font-size: 36px;
    }
  }
  &__arrows {
    position: absolute;
    right: 7px;
    bottom: 0;

    @media screen and (min-width: 1024px) {
      display: none;
    }
  }
  &__pointer {
    --border-width: 10px;

    position: absolute;
    z-index: 2;
    top: 100%;
    left: 22px;

    width: 120px;
    height: 46px;

    clip-path: polygon(100% 0%, 50% 100%, 0% 0%);
    background-color: var(--color-background);

    @media screen and (min-width: 1024px) {
      --border-width: 16px;

      top: calc(0px - var(--border-width));
      left: 100%;

      clip-path: polygon(0% 0%, 50% 50%, 0% 100%);
      width: 98px;
      height: calc(100% + var(--border-width) * 2);
    }

    &::after {
      content: '';
      position: absolute;
      z-index: 1;

      top: -1px;
      left: var(--border-width);
      right: var(--border-width);
      bottom: var(--border-width);

      clip-path: polygon(100% 0%, 50% 100%, 0% 0%);
      background-color: var(--color-background-contrast);

      @media screen and (min-width: 1024px) {
        clip-path: polygon(0% 0%, 50% 50%, 0% 100%);
        top: var(--border-width);
        left: 0;
      }
    }
  }

  &__content {
    position: relative;
    margin-top: 10px;
    padding: 58px 12px;
    background-color: var(--color-background-contrast);

    background-image: url('../assets/feature-background.png');
    background-position: top right;
    background-size: 346px auto;
    background-repeat: no-repeat;
  }

  &__close {
    position: absolute;
    width: 50px;
    height: 64px;
    top: 0;
    right: 0;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;

    &:hover {
      svg {
        fill: var(--color-background-contrast-light);
      }
    }
  }
  &__text {
    color: var(--color-text-contrast);
    font-size: 16px;
    line-height: 1.3;

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