<template>
  <div class="main-screen">
    <div class="main-screen__grid"></div>
    <div class="main-screen__background-logo">
      <img alt="HEMA League" src="../assets/background-logo.svg" />
    </div>

    <div class="main-screen__content">
      <div class="header">
        <img alt="Logo" class="header__logo" src="../assets/logo-badge.svg" width="70" />
        <div class="header__title title">HEMA League</div>

        <Divisions class="header__divisions" />
      </div>

      <div class="container">
        <div class="row">
          <div class="col-xs-12">
            <h1 class="main-screen__title title">
              Серия региональных <br />
              рейтинговых турниров
            </h1>
          </div>
        </div>

        <div class="row">
          <div class="col-xs-12">
            <div class="main-screen__registration">
              <div class="main-screen__registration-title">Регистрация открыта</div>
              <a
                href="https://t.me/gf_fencing_bot"
                target="_blank"
                class="main-screen__registration-button button"
              >
                Подать заявку
              </a>
            </div>
          </div>
        </div>

        <div class="row">
          <div class="col-xs-6 col-xs-offset-6 col-sm-5 col-sm-offset-1">
            <Divisions class="main-screen__divisions" />
          </div>
        </div>
      </div>
    </div>

    <div class="main-screen__arrows">
      <img src="../assets/half-arrows-white.svg" alt="Листай дальше" />
    </div>
  </div>
</template>

<script lang="ts" setup>
import Divisions from './Divisions.vue'
</script>


<style lang="scss" scoped>
.main-screen {
  position: relative;
  height: 100vh;
  width: 100%;
  overflow: hidden;

  background: linear-gradient(
    90.01deg,
    var(--color-background-contrast) 29.24%,
    var(--color-background-contrast-dark) 99.99%
  );
  color: var(--color-text-contrast);

  &__grid {
    position: absolute;
    z-index: 0;
    top: 0;
    right: 0;
    left: 0;
    bottom: 0;
    background-image: url('../assets/bg-item.svg');
  }
  &__background-logo {
    position: absolute;
    top: -1rem;
    left: -15rem;
    z-index: 0;
    width: 621px;

    @media screen and (min-width: 1400px) {
      top: -5rem;
      left: -11rem;
      width: 50%;
    }

    img {
      width: 100%;
    }
  }
  &__content {
    position: relative;
    z-index: 1;
    height: 100%;
    width: 100%;
  }
  &__title {
    font-size: 11vw;
    font-weight: normal;
    text-align: center;
    line-height: 1.3;
    margin-top: 74px;

    @media screen and (min-width: 560px) {
      font-size: 56px;
    }

    @media screen and (min-width: 640px) {
      margin-top: 100px;
    }

    @media screen and (min-width: 820px) {
      font-size: 64px;
    }

    @media screen and (min-width: 1024px) {
      margin-top: 0;
      font-size: 68px;
    }

    @media screen and (min-width: 1400px) {
      font-size: 82px;
      max-width: 1050px;
      margin: auto;
    }
  }

  &__arrows {
    position: absolute;
    right: 6px;

    top: 100%;
    transform: translateY(-100%);
    line-height: 0;

    img {
      width: 100%;
    }

    @media screen and (min-width: 1400px) {
      width: 609px;
    }
  }

  &__registration {
    margin-top: 6vh;
    text-align: center;

    @media screen and (min-width: 1024px) {
      margin-top: 8vh;
    }
  }
  &__registration-title {
    font-size: 20px;
    font-weight: bold;
    text-transform: uppercase;

    @media screen and (min-width: 560px) {
      font-size: 24px;
    }
    @media screen and (min-width: 1024px) {
      font-size: 36px;
    }
  }
  &__registration-button {
    margin-top: 16px;

    @media screen and (min-width: 1024px) {
      margin-top: 24px;
    }
  }

  &__divisions {
    display: block;
    @media screen and (min-width: 640px) {
      display: none;
    }
  }
}

.header {
  display: flex;
  padding: 0 16px;

  @media screen and (min-width: 560px) {
    font-size: 56px;
  }
  @media screen and (min-width: 1400px) {
    margin: auto;
    max-width: 90vw;
    justify-content: space-between;
    margin-bottom: 46px;
  }

  &__title {
    font-size: 24px;
    font-family: 'Amaz';
    margin-left: 10px;
    margin-top: 18px;

    @media (min-width: 1024px) {
      margin-top: 36px;
      font-size: 36px;
    }

    @media screen and (min-width: 1400px) {
      margin: 0;
      margin-top: 46px;
      order: 1;
    }
  }

  &__logo {
    @media (min-width: 1024px) {
      width: 140px;
    }
    @media (min-width: 1400px) {
      order: 2;
    }
    @media (min-width: 1900px) {
      width: 160px;
    }
  }

  &__divisions {
    display: none;
    @media screen and (min-width: 640px) {
      display: block;
    }
    @media screen and (min-width: 1400px) {
      margin: 0;
      margin-top: 38px;
      order: 3;
    }
  }
}
</style>
