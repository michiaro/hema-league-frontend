<template>
  <div class="divisions">
    <div class="divisions__title title">
      3 дивизиона
      <span class="divisions__footnote" title="Участвуют в Лиге в сезоне 2025-2026">
        <img alt="?" src="../assets/tooltip-icon.svg" />
      </span>
    </div>

    <div class="divisions__divider divider"></div>

    <div class="divisions__list">
      <div class="divisions__list-item">Центр</div>
      <div class="divisions__list-item">Урал</div>
      <div class="divisions__list-item">Сибирь</div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
.divisions {
  margin-top: 120px;
  margin-right: 16px;

  @media screen and (min-width: 560px) {
    margin-top: 64px;
  }

  @media screen and (min-width: 640px) {
    margin-top: 0;
    margin-right: 0;
    margin-left: auto;
  }

  @media screen and (min-width: 1024px) {
    margin-top: 20px;
  }

  &__title {
    font-size: 6vw;

    @media screen and (min-width: 560px) {
      font-size: 36px;
    }
  }
  &__footnote {
    margin-left: 6px;
    vertical-align: super;
    cursor: pointer;
  }
  &__divider {
  }
  &__list {
    display: flex;
    flex-flow: row nowrap;
    justify-content: space-between;
  }
  &__list-item {
    font-size: 4vw;

    @media screen and (min-width: 560px) {
      font-size: 18px;
    }
  }
}
</style>