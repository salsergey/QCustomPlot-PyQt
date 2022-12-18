/** PyQt5 binding for QCustomPlot v2.1.1
 *
 *  Authors: Sergey Salnikov
 *  License: MIT
 *
 *  QCustomPlot author: Emanuel Eichhammer
 *  QCustomPlot Website/Contact: http://www.qcustomplot.com
 */


class QCPPolarAxisRadial : public QCPLayerable
{
%TypeHeaderCode
#include <qcustomplot.h>
%End
public:
  enum AngleReference { arAbsolute    ///< The axis tilt is given in absolute degrees. The zero is to the right and positive angles are measured counter-clockwise.
                       ,arAngularAxis ///< The axis tilt is measured in the angular coordinate system given by the parent angular axis.
                      };

  enum ScaleType { stLinear       ///< Linear scaling
                   ,stLogarithmic ///< Logarithmic scaling with correspondingly transformed axis coordinates (possibly also \ref setTicker to a \ref QCPAxisTickerLog instance).
                 };

  enum SelectablePart { spNone        = 0      ///< None of the selectable parts
                        ,spAxis       = 0x001  ///< The axis backbone and tick marks
                        ,spTickLabels = 0x002  ///< Tick labels (numbers) of this axis (as a whole, not individually)
                        ,spAxisLabel  = 0x004  ///< The axis label
                      };
  typedef QFlags<QCPPolarAxisRadial::SelectablePart> SelectableParts;

  enum LabelMode { lmUpright   ///<
                   ,lmRotated ///<
                 };

  explicit QCPPolarAxisRadial(QCPPolarAxisAngular *parent /TransferThis/);
  virtual ~QCPPolarAxisRadial();

  // getters:
  bool rangeDrag() const;
  bool rangeZoom() const;
  double rangeZoomFactor() const;

  QCPPolarAxisAngular *angularAxis() const;
  ScaleType scaleType() const;
  const QCPRange range() const;
  bool rangeReversed() const;
  double angle() const;
  AngleReference angleReference() const;
  QCPAxisTicker* ticker() const;
  %MethodCode
    sipRes = sipCpp->ticker().data();
  %End
  bool ticks() const;
  bool tickLabels() const;
  int tickLabelPadding() const;
  QFont tickLabelFont() const;
  QColor tickLabelColor() const;
  double tickLabelRotation() const;
  LabelMode tickLabelMode() const;
  QString numberFormat() const;
  int numberPrecision() const;
  QVector<double> tickVector() const;
  QVector<double> subTickVector() const;
  QVector<QString> tickVectorLabels() const;
  int tickLengthIn() const;
  int tickLengthOut() const;
  bool subTicks() const;
  int subTickLengthIn() const;
  int subTickLengthOut() const;
  QPen basePen() const;
  QPen tickPen() const;
  QPen subTickPen() const;
  QFont labelFont() const;
  QColor labelColor() const;
  QString label() const;
  int labelPadding() const;
  SelectableParts selectedParts() const;
  SelectableParts selectableParts() const;
  QFont selectedTickLabelFont() const;
  QFont selectedLabelFont() const;
  QColor selectedTickLabelColor() const;
  QColor selectedLabelColor() const;
  QPen selectedBasePen() const;
  QPen selectedTickPen() const;
  QPen selectedSubTickPen() const;

  // setters:
  void setRangeDrag(bool enabled);
  void setRangeZoom(bool enabled);
  void setRangeZoomFactor(double factor);

  Q_SLOT void setScaleType(QCPPolarAxisRadial::ScaleType type);
  Q_SLOT void setRange(const QCPRange &range);
  void setRange(double lower, double upper);
  void setRange(double position, double size, Qt::AlignmentFlag alignment);
  void setRangeLower(double lower);
  void setRangeUpper(double upper);
  void setRangeReversed(bool reversed);
  void setAngle(double degrees);
  void setAngleReference(AngleReference reference);
  void setTicker(QCPAxisTicker *ticker /Transfer/);
  %Docstring(format = "deindented", signature = "prepended")
    Set a new ticker on the axis. Ownership of the ticker is transferred to the axis
    and cannot be taken back.
  %End
  %MethodCode
    sipCpp->setTicker(QSharedPointer<QCPAxisTicker>(a0));
  %End
  void setTicks(bool show);
  void setTickLabels(bool show);
  void setTickLabelPadding(int padding);
  void setTickLabelFont(const QFont &font);
  void setTickLabelColor(const QColor &color);
  void setTickLabelRotation(double degrees);
  void setTickLabelMode(LabelMode mode);
  void setNumberFormat(const QString &formatCode);
  void setNumberPrecision(int precision);
  void setTickLength(int inside, int outside=0);
  void setTickLengthIn(int inside);
  void setTickLengthOut(int outside);
  void setSubTicks(bool show);
  void setSubTickLength(int inside, int outside=0);
  void setSubTickLengthIn(int inside);
  void setSubTickLengthOut(int outside);
  void setBasePen(const QPen &pen);
  void setTickPen(const QPen &pen);
  void setSubTickPen(const QPen &pen);
  void setLabelFont(const QFont &font);
  void setLabelColor(const QColor &color);
  void setLabel(const QString &str);
  void setLabelPadding(int padding);
  void setSelectedTickLabelFont(const QFont &font);
  void setSelectedLabelFont(const QFont &font);
  void setSelectedTickLabelColor(const QColor &color);
  void setSelectedLabelColor(const QColor &color);
  void setSelectedBasePen(const QPen &pen);
  void setSelectedTickPen(const QPen &pen);
  void setSelectedSubTickPen(const QPen &pen);
  Q_SLOT void setSelectableParts(const QCPPolarAxisRadial::SelectableParts &selectableParts);
  Q_SLOT void setSelectedParts(const QCPPolarAxisRadial::SelectableParts &selectedParts);

  // reimplemented virtual methods:
  virtual double selectTest(const QPointF &pos, bool onlySelectable, QVariant *details=0) const;

  // non-property methods:
  void moveRange(double diff);
  void scaleRange(double factor);
  void scaleRange(double factor, double center);
  void rescale(bool onlyVisiblePlottables=false);
  void pixelToCoord(QPointF pixelPos, double &angleCoord, double &radiusCoord) const;
  QPointF coordToPixel(double angleCoord, double radiusCoord) const;
  double coordToRadius(double coord) const;
  double radiusToCoord(double radius) const;
  SelectablePart getPartAt(const QPointF &pos) const;

signals:
  void rangeChanged(const QCPRange &newRange);
  void rangeChanged(const QCPRange &newRange, const QCPRange &oldRange);
  void scaleTypeChanged(QCPPolarAxisRadial::ScaleType scaleType);
  void selectionChanged(const QCPPolarAxisRadial::SelectableParts &parts);
  void selectableChanged(const QCPPolarAxisRadial::SelectableParts &parts);

protected:
  // reimplemented virtual methods:
  virtual void applyDefaultAntialiasingHint(QCPPainter *painter) const;
  virtual void draw(QCPPainter *painter);
  virtual QCP::Interaction selectionCategory() const;
  // events:
  virtual void selectEvent(QMouseEvent *event, bool additive, const QVariant &details, bool *selectionStateChanged);
  virtual void deselectEvent(bool *selectionStateChanged);
  // mouse events:
  virtual void mousePressEvent(QMouseEvent *event, const QVariant &details);
  virtual void mouseMoveEvent(QMouseEvent *event, const QPointF &startPos);
  virtual void mouseReleaseEvent(QMouseEvent *event, const QPointF &startPos);
  virtual void wheelEvent(QWheelEvent *event);

  // non-virtual methods:
  void updateGeometry(const QPointF &center, double radius);
  void setupTickVectors();
  QPen getBasePen() const;
  QPen getTickPen() const;
  QPen getSubTickPen() const;
  QFont getTickLabelFont() const;
  QFont getLabelFont() const;
  QColor getTickLabelColor() const;
  QColor getLabelColor() const;
};

QFlags<QCPPolarAxisRadial::SelectablePart> operator|(QCPPolarAxisRadial::SelectablePart f1, QFlags<QCPPolarAxisRadial::SelectablePart> f2);
QFlags<QCPPolarAxisRadial::SelectablePart> operator&(QCPPolarAxisRadial::SelectablePart f1, QFlags<QCPPolarAxisRadial::SelectablePart> f2);
