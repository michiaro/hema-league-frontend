<template>
  <div class="news">
    <div class="container container-fluid">
      <div class="row">
        <div class="col col-xs-12">
          <h2 class="news__title title">Следи за новостями</h2>
        </div>

        <div class="col col-xs-12 col-xl-6">
          <div class="news__content">
            <p>
              Полные правила для каждого снаряда читай
              <a class="news__link" href="https://hema-magisterium.ru/rules" target="_blank">
                по&nbsp;ссылке</a
              >.
              <br />
              Правила расчета рейтинга и другие важные моменты читай
              <a
                class="news__link"
                href="https://purlakpv.github.io/fencing-brain/"
                target="_blank"
              >
                в&nbsp;положении</a
              >.
            </p>
            <p>
              Следи за обновлениями и подписывайся на нас ВКонтакте, чтобы быть в курсе всех
              новостей!
            </p>
            <p>Группы организаторов по регионам:</p>
            <div class="news__social-links">
              <a class="news__link" href="https://vk.com/twc_yar" target="_blank">Центр</a>
              <a class="news__link" href="https://vk.com/golden_falcon74" target="_blank">Урал</a>
              <a class="news__link" href="https://vk.com/golden_falcon54" target="_blank">
                Сибирь
              </a>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
.news {
  margin-top: 64px;

  @media screen and (min-width: 1024px) {
    margin-top: 74px;
  }

  &__title {
    font-size: 32px;
    margin-bottom: 16px;

    @media screen and (min-width: 1024px) {
      font-size: 74px;
      margin-bottom: 36px;
    }
  }
  &__content {
    font-size: 16px;
    line-height: 1.3;

    @media screen and (min-width: 1024px) {
      font-size: 24px;
    }

    p {
      margin: 10px 0 0;
    }
  }

  &__link {
    text-decoration: none;
    color: var(--color-background-contrast);
    border-bottom: 2px solid var(--color-background-contrast);
  }

  &__social-links {
    margin-top: 10px;
    * + * {
      margin-left: 16px;
    }
  }
}
</style>

