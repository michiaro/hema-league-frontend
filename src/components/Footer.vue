<template>
  <div class="footer">
    <div class="container container-fluid">
      <div class="row">
        <div class="col col-xs-6 col-md-2">
          <div class="footer__logo">
            <img src="../assets/text-logo.svg" alt="HEMA League" />
          </div>
        </div>

        <div class="col col-xs-10 col-md-4">
          <div class="footer__text">Серия рейтинговых региональных турниров HEMA League</div>
        </div>

        <div class="col col-xs-12 col-lg-4 col-lg-offset-2">
          <div class="footer__organizers">
            <div class="footer__organizers-title title">Организаторы</div>
            <div class="footer__organizers-list">
              <div class="footer__organizer">
                <img src="../assets/gf-logo.svg" alt="Золотой Сокол Челябинск" />
              </div>
              <div class="footer__organizer">
                <img src="../assets/white-company-logo.png" alt="Золойто Сокол Челябинск" />
              </div>
              <div class="footer__organizer">
                <img src="../assets/gf-nsk-logo.svg" alt="Золотой Сокол Новосибирск" />
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
.footer {
  padding: 10px 0 64px;
  background: linear-gradient(
    180deg,
    var(--color-background-contrast) 0%,
    var(--color-background-contrast-dark) 148.37%
  );
  color: var(--color-text-contrast);

  &__logo {
    width: 148px;
    margin-bottom: 16px;
  }
  &__text {
    font-size: 16px;
    line-height: 1.1;
    margin-bottom: 46px;

    @media screen and (min-width: 1024px) {
      padding-top: 10px;
    }
  }
  &__organizers {
    @media screen and (min-width: 1024px) {
      padding-top: 10px;
    }
  }
  &__organizers-title {
    margin-bottom: 16px;

    @media screen and (min-width: 1024px) {
      margin-bottom: 24px;
      font-size: 36px;
    }
  }
  &__organizers-list {
    display: flex;
  }
  &__organizer {
    & + & {
      margin-left: 32px;

      @media screen and (min-width: 1400px) {
        margin-left: 46px;
      }
    }

    img {
      max-height: 73px;
    }
  }
}
</style>